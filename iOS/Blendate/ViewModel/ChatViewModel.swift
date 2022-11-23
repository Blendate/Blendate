//
//  ChatViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var chatMessages = [ChatMessage]()
    @Published var count = 0
    
    let conversation: Conversation
    
    let service = MessageService()

        
    init(_ convo: Conversation){
        self.conversation = convo
        self.count += 1
        fetchMessages()
    }
    
    private func fetchMessages(){
        guard let collection = service.collection(for: conversation.id) else {return}
        collection
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
//                guard error == nil else { return}
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        if let message = try? change.document.data(as: ChatMessage.self){
                            self.chatMessages.append(message)
                        } else {
                            print("Decode Error For: \(change.document.documentID)")
                        }
                    }
                })
            }
    }
        
    func sendMessage(to uid: String?) async {
        do {
            guard let author = conversation.withUserID(uid) else {return}
            try await service.sendMessage(convo: conversation, message: text, author: author)
            self.text = ""
            self.count += 1
        } catch {
            print("Send Message Error: \(error.localizedDescription)")
        }
    }

}
