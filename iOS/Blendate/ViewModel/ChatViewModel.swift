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
        
    init(_ conversation: C){
        self.conversation = conversation
        super.init(collection: Self.Messages(for: conversation), listener: true)
    }
        
    func sendMessage(author: String) {
        do {
            let chatMessage = ChatMessage(author: author, text: text)
            try create(chatMessage)
            if let cid = conversation.id {
                conversation.lastMessage = chatMessage
                try? Self.Collection(for: conversation).document(cid).setData(from: conversation)
            }
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
