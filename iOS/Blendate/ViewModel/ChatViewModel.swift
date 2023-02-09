//
//  ChatViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import Foundation
import FirebaseFirestore

@MainActor
class ChatViewModel<C:Convo>: FirestoreService<ChatMessage> {
    
    @Published var text: String = ""
    @Published var error: AlertError?
    
    var cid: String
        
    init(cid: String, text: String = "", listener: Bool = true){
        self.cid = cid
        self.text = text
        super.init(collection: C.messages(for: cid), listener: listener)
    }
    
    func sendMessage(author: String) {
        let chatMessage = ChatMessage(author: author, text: text)
        do {
            try sendMessage(chatMessage)
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


