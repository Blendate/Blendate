//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI

@MainActor
class MatchViewModel: ObservableObject {
    
    @Published var lineup: [Details] = []
    @Published var loading = true
    @Published var newConvo: Conversation?
    
    private let detailService: DetailService
    private let chatService: MessageService
    private let uid: String
    init(_ uid: String,
         _ chat: MessageService = MessageService(),
         _ detail: DetailService = DetailService()
    ){
        self.uid = uid
        self.chatService = chat
        self.detailService = detail
        getLineup()
    }
    
    func getLineup() {
        Task { @MainActor in
            do {
                self.lineup = try await detailService.fetchLineup(for: uid)
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
