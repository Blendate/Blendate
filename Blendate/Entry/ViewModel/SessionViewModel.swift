//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI
import Firebase

@MainActor
class SessionViewModel: ObservableObject {

    @Published var selectedTab: Int = 3
    @Published var user: User = User()
    @Published var loadingState: SessionState = .loading
    @Published var showLoading = true


    private let uid: String
    let userService: UserService = UserService()
    
    init(_ uid: String){
        self.uid = uid
    }
    
    func getUserDoc() async {
        printD("Fetching Doc for: \(uid)")
        do {
            self.user = try await FirebaseManager.instance.fetchUser(from: uid)
            self.loadingState = validUser() ? .user : .noUser
            if let prov = getProvider(),
               !self.user.settings.providers.contains(prov) {
                self.user.settings.providers.append(prov)
            }
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 1 second
            withAnimation(.spring()) {
                showLoading = false
            }
        } catch {
            printD(error.localizedDescription)
            loadingState = .noUser
            withAnimation(.spring()) {
                showLoading = false
            }
        }
    }

    private func validUser()->Bool {
        let _ = self.user.settings.onboarded
        return true
    }
    
    func requestAuthorizationForNotifications() async {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            if granted != self.user.settings.notifications {
                self.user.settings.notifications = granted
                if let fcm = UserDefaults.standard.string(forKey: "fcm"),
                   self.user.fcm.isEmpty {
                    self.user.fcm = fcm
                }
                try UserService().updateUser(with: self.user)
            }

        } catch {
            printD(error)
        }
    }
    
    private func getProvider() -> Provider? {
        guard let user = FirebaseManager.instance.auth.currentUser else {return nil }

        for i in user.providerData {
            print(i.providerID)
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    return Provider(type: .apple, email: i.email ?? "")
                case "facebook.com":
                    return Provider(type: .facebook, email: i.email ?? "")
                case "google.com":
                    return Provider(type: .google, email: i.email ?? "")
                case "twitter.com":
                    return Provider(type: .twitter, email: i.email ?? "")
                default:
                    return Provider(type: .email, email: i.email ?? "")
                }
            } else {
                return nil
            }
        }
        return nil
    }

    
}
