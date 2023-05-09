//
//  NavigationManager.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/3/23.
//

import SwiftUI
import FirebaseAuth
import Firebase

@MainActor
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
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func delete() {
        auth.currentUser?.delete { error in
            self.signOut()
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
                let user = try await FireStore.instance.fetch(uid: uid)
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
