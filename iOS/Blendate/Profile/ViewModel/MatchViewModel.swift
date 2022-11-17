//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI
enum Swipe: String { case pass = "passes", like = "likes" }

@MainActor
class MatchViewModel: ObservableObject {
    
    @Published var lineup: [User] = []
    @Published var matched = false
    @Published var loading = true
    @Published var newConvo = Conversation(users: [], chats: [], timestamp: Date())
    
    let service = MatchService()
    
    init(){
        getLineup()
    }
    
    func getLineup() {
        Task { @MainActor in
            do {
                self.lineup = try await service.fetchLineup()
                withAnimation(.spring()) {
                    loading = false
                }
            } catch {
                print("Fetch Lineup Error: \(error.localizedDescription)")
                withAnimation(.spring()) {
                    loading = false
                }
            }
        }

    }

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