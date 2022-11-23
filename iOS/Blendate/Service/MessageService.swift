//
//  MessageService.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import Foundation
import FirebaseFirestore

enum Swipe: String { case pass = "passes", like = "likes" }
class MessageService: FirebaseService<Conversation> {

    init() {
        super.init(collection: "chats")
    }
    
    func collection(for cid: String?) -> CollectionReference? {
        guard let cid = cid else {return nil}
        return collection.document(cid).collection("chats")
    }
    
    func sendMessage(convo: Conversation, message: String, author: String) async throws {
        do {
            let cid = try fid(convo, nil)
            let convoReference = collection.document(cid)
            let chatDocument = convoReference.collection("chats").document()
            
            let chatMessage = ChatMessage(author: author, text: message)
            try chatDocument.setData(from: chatMessage)
            convo.lastMessage = chatMessage
            try update(convo)
        } catch {
            throw AlertError(title: "Server Error", message: "There was an error sending your message.", recovery: "Try Again")
        }
    }
    
    
    
    func swiped(uid: String, on match: String?, _ swipe: Swipe) async throws -> Conversation? {
        guard let match = match else { throw FirebaseService<Conversation>.serverError }
        devPrint("Swiped \(swipe.rawValue.capitalized) on \(match)")
        do {
            try await Users.document(uid)
                .collection(swipe.rawValue)
                .document(match)
                .setData(["timestamp":Date()])
            
            let likes = await getHistory(for: match, .like)
            
            guard swipe == .like && likes.contains(uid) else {return nil}
            
            let convo = Conversation(user1: match, user2: uid)
            try create(convo)
            return convo
        } catch {
            throw AlertError(title: "Server Error", message: "Could not save your swipe on the Blendate server.", recovery: "Try Again")
        }
    }
}
