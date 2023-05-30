//
//  NavigationManager.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/3/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

class NavigationManager: ObservableObject {
    
    static let shared = NavigationManager()
    enum State { case loading, noUser, onboarding(String), user(String, User) }
    
    @Published var selectedTab: Tab = .match
    @Published var state: State = .loading
    @Published var showPurchaseMembership = false
    @Published var showPurchaseLikes = false
    
    let auth = Auth.auth()
    
    init() {
        addAuthStateListener()
    }
    

    @MainActor
    func navigate(to tab: Tab) {
        self.selectedTab = tab
    }
    
    
    @MainActor
    func signOut() {
        do {
            try auth.signOut()
            state = .noUser
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func delete() {
        auth.currentUser?.delete { error in
            if let error {
                print(error)
            } else {
                self.signOut()
            }
        }
    }
    
}


// MARK: AuthState Listener
extension NavigationManager {

    private func addAuthStateListener() {
        auth.addStateDidChangeListener { auth, user in
            if let uid = user?.uid {
                self.fetch(uid)
            } else {
                withAnimation {
                    self.state = .noUser
                }
            }
        }
    }
    
    func fetch(_ uid: String) {
        Task {@MainActor in
            do {
                let user = try await FireStore.shared.fetch(uid: uid)
                print("Fetched \(uid)")
                withAnimation {
                    self.state = .user(uid, user)
                }
            } catch {
                print(error.localizedDescription)
                withAnimation {
                    self.state = .onboarding(uid)
                }
            }
        }
    }

}

enum Tab: String, CaseIterable, Identifiable {
    var id: String {self.rawValue }
    case match, likes, messages, community, profile

    var image: Image {
        switch self {

        case .match:
            return Image("icon-2")
        case .likes:
            return Image(systemName: "star")
        case .messages:
            return Image("chat")
        case .community:
            return Image(systemName: "person.3")
        case .profile:
            return Image("profile")
        }
    }
}
