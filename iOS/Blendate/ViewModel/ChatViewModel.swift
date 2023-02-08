//
//  ChatViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import Foundation

@MainActor
class ChatViewModel<C:Convo>: FirestoreService<ChatMessage> {
    
    @Published var text: String = ""
    @Published var error: AlertError?
    
    var conversation: C
        
    init(_ conversation: C, text: String = ""){
        self.conversation = conversation
        self.text = text
        let collection = Self.Messages(for: conversation)
        super.init(parent: collection, listener: true)
    }
        
    func sendMessage(author: String) {
        do {
            let chatMessage = ChatMessage(author: author, text: text)
            let _ = try create(chatMessage)
            conversation.lastMessage = chatMessage
            try? FirestoreService<C>().update(conversation)
            clear()
        } catch {
            print("Send Message Error: \(error.localizedDescription)")
            self.error = AlertError(title: "Server Error", message: "There was an error sending your message.", recovery: "Try Again")
        }
    }
    
    @MainActor
    private func clear(){
        self.text = ""
    }

}
