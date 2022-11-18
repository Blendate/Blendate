//
//  MessageService.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import Foundation
import FirebaseFirestore

class MessageService {
    
    let firebase = FirebaseManager.instance
    
    func sendMessage(conversationID: String?, message: String) async throws {
        let uid = try firebase.checkUID()
        guard let cid = conversationID else { throw FirebaseError.generic("Invalid Conversation")}
        let documentReference = firebase.Chats.document(cid)
        
        
        let document = documentReference
            .collection("chats")
            .document()
        
        let chatMessage = ChatMessage(author: uid, text: message)
        try document.setData(from: chatMessage)
//        try await documentReference.updateData(["lastMessage":chatMessage])
        print("Message Sent: \(chatMessage.timestamp)")
        let convoDoc = try await documentReference.getDocument()
        let convo = try convoDoc.data(as: Conversation.self)
        
        try documentReference.setData(from: convo)

        
    }
    


}
