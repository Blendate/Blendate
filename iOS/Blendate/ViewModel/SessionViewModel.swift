//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI

enum SessionState {case noUser, user}

class SessionViewModel: FirestoreService<User> {

    @Published var selectedTab: Tab = .match
    @Published var state: SessionState = .user
    
    @Published var user = User()
    
    let uid: String
    
    init(_ uid: String){
        self.uid = uid
        super.init()
        print("Init \(uid)")
    }
    
    #warning("better check than just firstname")
    @MainActor
    func fetchFirebase() async {
        do {
            self.user = try await fetch(fid: uid)
            withAnimation(.spring()) {
                state = user.firstname.isEmpty ? .noUser : .user
            }
        } catch {
            print(error.localizedDescription)
            withAnimation(.spring()) {
                state = .noUser
            }
        }
    }

    @MainActor
    func createUserDoc() throws {
        let _ = try create(user, fid: uid)
        let _ = try FirestoreService<User.Settings>().create(User.Settings(), fid: uid)
        state = .user
    }

    func save() throws {
        try update(user)
    }

}
