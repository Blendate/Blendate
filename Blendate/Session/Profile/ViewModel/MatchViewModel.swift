//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI
enum Swipe: String { case pass = "passes", like = "likes" }

class MatchViewModel: ObservableObject {
    
    @Published var lineup: [User] = []
    @Published var matched = false
    @Published var loading = true
    @Published var newConvo = Conversation(users: [], chats: [], timestamp: Date())
    
    let service = MatchService()
    
    @MainActor
    func getLineup() async {
        do {
            let combine = try await service.fetchSwipeHistory()
            let snapshot = try await FirebaseManager.instance.Users
                .whereField(.documentID(), notIn: combine)
                .getDocuments()
            let uid = try FirebaseManager.instance.checkUID()
            let users = snapshot.documents
                .filter({$0.documentID != uid})
                .compactMap { document in
                    try? document.data(as: User.self)
            }
            self.lineup = users
            try? await Task.sleep(nanoseconds: 3 * 1_000_000_000) // 1 second
            withAnimation(.spring()) {
                loading = false
            }
        } catch {
            printD(error.localizedDescription)
            withAnimation(.spring()) {
                loading = false
            }
        }
    }
    
    @MainActor
    func swipe(on swipedUID: String?, _ swipe: Swipe) {
        Task {
            if let convo = try await service.swiped(swipe, on: swipedUID) {
                self.newConvo = convo
                self.matched = true

            } else {
                self.lineup.removeFirst()
            }
        }
    }
}
