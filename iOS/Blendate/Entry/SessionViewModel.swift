//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI
import RevenueCat

enum SessionState {case noUser, user, loading}

@MainActor
class SessionViewModel: ObservableObject {

    @Published var selectedTab: Tab = .match
    @Published var loadingState: SessionState = .loading
    
    @Published var settings: Settings
    @Published var user: User
    
    @Published var showMembership = false
    @Published var showSuperLike = false

    let uid: String
    
    private let userService: UserService = UserService()
    private let settingsService: FirebaseService = FirebaseService<Settings>(collection: "settings")
    
    init(_ uid: String){
        self.uid = uid
        self.user = User(id: uid)
        self.settings = Settings(id: uid)
        print("📱 [Session] \(uid)")
    }
    
    func fetchFirebase() async {

        do {
            self.settings = try await settingsService.fetch(fid: uid)
            self.user = try await userService.fetch(fid: uid)
            self.user.photos = user.photos.sorted(by: {$0.placement < $1.placement})
            await loginRevenueCat()
            withAnimation(.spring()) {
                self.loadingState = user.firstname.isEmpty ? .noUser : .user
            }
        } catch {
            withAnimation(.spring()) {
                loadingState = .noUser
            }
        }
    }
    
    private func loginRevenueCat() async {
        try? await RevenueCatService.logIn(uid)
//        if let info = customerInfo {
//            print(customerInfo)
//        }
    }

    func createUserDoc() throws {
        print("CREATE \(user.id ?? "NOID")")
        try userService.create(user)
        let settings = Settings(id: user.id)
        try settingsService.create(settings)
        loadingState = .user
    }
    
    func saveSettings() throws {
        try settingsService.update(settings)
    }
    
    func saveUser() throws {
        try userService.update(user)
    }
}

extension SessionViewModel {
    
    func checkNotification() async {
        do {
            let notificationCenter = UNUserNotificationCenter.current()
            let authStatus: UNAuthorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
            
            let fcm = UserDefaults.standard.string(forKey: String.kFCMstring)
            
            switch authStatus {
            case .notDetermined:
                let approved = try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
                if let fcm = fcm, approved {
                    settings.notifications = Notifications(fcm: fcm, isOn: true)
                    try userService.update(user)
                }
            case .authorized:
                if let fcm = fcm, settings.notifications.fcm != fcm {
                    settings.notifications = Notifications(fcm: fcm, isOn: true)
                    try userService.update(user)
                }
            default:
                break
            }
        } catch {
            print("🔔 [Notification] Error")
            print(error)
        }
    }
}


