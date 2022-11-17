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

    @Published var selectedTab: Int = 0
    @Published var user: User = User()
    @Published var loadingState: SessionState = .loading

    private let uid: String
    
    let userService: UserService = UserService()
    
    init(_ uid: String){
        self.uid = uid
    }
    
    func getUserDoc() async {
        do {
            self.user = try await userService.fetchUser(from: uid)
            withAnimation(.spring()) {
                self.loadingState = user.settings.onboarded ? .user : .noUser
            }
        } catch {
            print("UserDoc Error: \(error.localizedDescription)")
            withAnimation(.spring()) {
                loadingState = .noUser
            }
        }
    }

    func createUserDoc() throws {
        var cache = user
        cache.settings.onboarded = true
        try createDoc(from: cache)
        user = cache
        loadingState = .user

    }
    
    private func createDoc(from user: User) throws {
        let uid = try FirebaseManager.instance.checkUID()
        var cache = user
        cache.id = uid
        cache.settings.onboarded = true
        cache.settings.providers = FirebaseManager.instance.getProviders() ?? []
        try FirebaseManager.instance.Users.document(uid)
            .setData(from: cache)
    }
    
    func checkNotification() async {
        do {
            let notificationCenter = UNUserNotificationCenter.current()
            let authStatus:UNAuthorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
            let fcm = UserDefaults.standard.string(forKey: "fcm")
            switch authStatus {
            case .notDetermined:
                let approved = try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
                if let fcm = fcm, approved {
                    user.settings.notifications = Notifications(isOn: true)
                    user.fcm = fcm
                    try userService.update(user)
                } else {
                }
            case .authorized:
                if let fcm = fcm {
                    user.fcm = fcm
                    print("Updating FCM")
                    try userService.update(user)
                } else {
                }
            default:
                break
            }
        } catch {
            print(error.localizedDescription)
        }
    }

}
