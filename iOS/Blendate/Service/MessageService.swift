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
    
    func sendMessage(cid: String?, message: String, author: String) async throws {
        guard let cid = cid else { throw FirebaseError.generic("Invalid Conversation") }
        let convoReference = collection.document(cid)
        let document = convoReference.collection("chats").document()
        
        let chatMessage = ChatMessage(author: author, text: message)
        try document.setData(from: chatMessage)
        
        var convo = try await fetch(fid: cid)
        convo.lastMessage = chatMessage
        try convoReference.setData(from: convo)

    }
    
    
    
    func swiped(uid: String, on match: String?, _ swipe: Swipe) async throws -> Conversation? {
        guard let match = match else { throw ErrorInfo() }
        try await Users.document(uid).collection(swipe.rawValue).document(match)
            .setData(["timestamp":Date()])
        
        let likes = await getHistory(for: match, .like)
        
        guard swipe == .like && likes.contains(uid) else {return nil}
        
        let cid = Self.getUsersID(userId1: uid, userId2: match)
        let convo = Conversation(id: cid, users: [match, uid], timestamp: .now)
        do {
            try create(convo)
            return convo
        } catch {
            throw FirebaseError.generic("There was an error creating the match on the server")
        }


    }


}
