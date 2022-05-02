//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI

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
        printD("Fetching Doc for: \(uid)")
        do {
            self.user = try await userService.fetchUser(from: uid)
            withAnimation(.spring()) {
                self.loadingState = user.settings.onboarded ? .user : .noUser
            }
        } catch {
            printD(error.localizedDescription)
            withAnimation(.spring()) {
                loadingState = .noUser
            }
        }
    }
    
    func checkNotification() async {
        do {
            let notificationCenter = UNUserNotificationCenter.current()
            let authStatus:UNAuthorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
            let fcm = UserDefaults.standard.string(forKey: "fcm")
            printD("FCM: \(fcm ?? "NONE")")
            switch authStatus {
            case .notDetermined:
                print("Not Determined")
                let approved = try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
                if let fcm = fcm, approved {
                    user.settings.notifications = Notifications(isOn: true)
                    user.fcm = fcm
                    try userService.updateUser(with: user)
                } else {
                    print("NO FCM")
                }
            case .authorized:
                print("Authorized")

                if let fcm = fcm {
                    print("Valid fcm attempting to set: ")
                    user.fcm = fcm
                    try userService.updateUser(with: user)
                } else {
                    print("User: \(user.fcm)")
                }
            default:
                print("Othjer")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
