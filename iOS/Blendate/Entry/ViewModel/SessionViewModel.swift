//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI

enum SessionState {case noUser, user, loading}

@MainActor
class SessionViewModel: ObservableObject {

    @Published var selectedTab: Tab = .match
    @Published var loadingState: SessionState = .loading
    
    @Published var user: User = User()
    @Published var details: Details = Details()

    let uid: String
    
    private let userService: UserService
    private let detailService: DetailService
    
    init(_ uid: String,
         _ user: UserService = UserService(),
         _ detail: DetailService = DetailService()
    ){
        self.uid = uid
        self.userService = user
        self.detailService = detail
    }
    
    func fetchFirebase() async {
        do {
            self.user = try await userService.fetch(fid: uid)
            self.details = try await detailService.fetch(fid: uid)
            self.details.photos = details.photos.sorted(by: {$0.placement < $1.placement})
            withAnimation(.spring()) {
                self.loadingState = user.settings.onboarded ? .user : .noUser
            }
        } catch {
            userService.devPrint("UserDoc Error: \(error.localizedDescription)")
            withAnimation(.spring()) {
                loadingState = .noUser
            }
        }
    }

    func createUserDoc() throws {
        var cache = user
//        cache.id = uid
        cache.settings.onboarded = true
        cache.settings.providers = FirebaseManager.instance.getProviders() ?? []
        try userService.create(cache)
        try detailService.create(details)
        self.user = cache
        loadingState = .user
    }
    
    func saveDetails() throws {
        try detailService.update(details)
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
                    user.settings.notifications = Notifications(isOn: true)
                    user.fcm = fcm
                    try userService.update(user)
                }
            case .authorized:
                if let fcm = fcm, user.fcm != fcm {
                    userService.update(fcm: fcm)
                    user.fcm = fcm
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
