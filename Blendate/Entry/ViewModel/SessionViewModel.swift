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

extension SessionViewModel {
    
    func creasteUserDoc() throws {
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
        cache.settings.providers = getProviders() ?? []
        //        try LocalFileManager.instance.store(user: user)
        try FirebaseManager.instance.Users.document(uid).setData(from: cache)
    }
    
    private func getProviders() -> [Provider]? {
        guard let user = FirebaseManager.instance.auth.currentUser else {return nil }
        
        var providers = [Provider]()
        for i in user.providerData {
            printD("Provider: \(i.providerID)\nEmail: \(i.email ?? "None")")
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    providers.append(Provider(type: .apple, email: i.email) )
                case "facebook.com":
                    providers.append(Provider(type: .facebook, email: i.email) )
                case "google.com":
                    providers.append(Provider(type: .google, email: i.email) )
                case "twitter.com":
                    providers.append(Provider(type: .twitter, email: i.email) )
                default:
                    providers.append(Provider(type: .email, email: i.email) )
                }
            }
        }
        return providers
    }
}
