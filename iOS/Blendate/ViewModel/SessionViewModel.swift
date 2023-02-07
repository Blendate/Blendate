//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI

enum SessionState {case noUser, user, loading}

class SessionViewModel: FirestoreService<User> {

    @Published var selectedTab: Tab = .match
    @Published var loadingState: SessionState = .loading
    
    @Published var user: User

    let uid: String
    init(_ uid: String){
        self.uid = uid
        self.user = User(id: uid)
        super.init(collection: Self.Users)
        print("Init \(uid)")
    }
    
    #warning("better check than just firstname")
    @MainActor
    func fetchFirebase() async {
        do {
            self.user = try await fetch(fid: uid)
            withAnimation(.spring()) {
                self.loadingState = user.firstname.isEmpty ? .noUser : .user
            }
        } catch {
            print(error.localizedDescription)
            withAnimation(.spring()) {
                loadingState = .noUser
            }
        }
    }

    @MainActor
    func createUserDoc() throws {
        try create(user)
        
        let settingsService = FirestoreService<User.Settings>(collection: Self.Settings)
        try settingsService.create( User.Settings(id: user.id) )
        loadingState = .user
    }

    func saveUser() throws {
        try update(user)
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
