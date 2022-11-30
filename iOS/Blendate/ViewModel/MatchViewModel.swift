//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI

@MainActor
class MatchViewModel: ObservableObject {
    
    @Published var lineup: [User] = []
    @Published var loading = true
    @Published var newConvo: Conversation?
    
    private let userService = UserService()
    private let chatService = MessageService()
    private let uid: String
    init(_ uid: String){
        self.uid = uid
        getLineup()
    }
    
    func getLineup() {
        Task { @MainActor in
            do {
                self.lineup = try await userService.fetchLineup(for: uid)
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
            if let convo = try await chatService.swiped(uid: uid, on: swipedUID, swipe) {
                self.newConvo = convo
            } else {
                self.lineup.removeFirst()
            }
        }
    }
}
