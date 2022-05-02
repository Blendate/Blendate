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

            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 1 second
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
    
    func checkNotification() async -> Bool {
        do {
            let notificationCenter = UNUserNotificationCenter.current()
            let authStatus:UNAuthorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
            
            switch authStatus {
            case .notDetermined:
                return try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
            case .authorized:
                return true
            default:
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
