//
//  MatchService.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import Foundation

class MatchService {
    
    let firebase = FirebaseManager.instance
    
    func fetchSwipeHistory() async throws -> [String]{
        let uid = try firebase.checkUID()
        
        let passes:[String] = (try? await firebase.Passes(for: uid).getDocuments().documents
            .compactMap { $0.documentID }) ?? []
        let likes: [String] = (try? await firebase.Likes(for: uid).getDocuments().documents
            .compactMap { $0.documentID }) ?? []
        
        let combine = likes + passes
        return combine.isEmpty ? ["empty"] : combine
        
    }
    
    func swiped(_ swipe: Swipe, on swipedUID: String?) async throws -> Conversation? {
        let uid = try firebase.checkUID()
        guard let swipedUID = swipedUID else { throw ErrorInfo() }
        let swipeString = swipe.rawValue
        
        try await firebase.Users.document(uid).collection(swipeString).document(swipedUID)
            .setData(["timestamp":Date()])
        
        let swipedUserLikes: [String] = (try? await firebase.Likes(for: swipedUID).getDocuments().documents
            .compactMap { $0.documentID }) ?? []
        
        if swipe == .like && swipedUserLikes.contains(uid) {
            let convoID = FirebaseManager.getUsersID(userId1: uid, userId2: swipedUID)
            let convo = Conversation(id: convoID, users: [swipedUID, uid], chats: [], timestamp: Date())
            do {
                let _ = try startConvo(convo)
                return convo
            } catch {
                throw FirebaseError.generic("There was an error creating the match on the server")
            }
        } else {
            return nil
        }
        
    }
    
    private func startConvo(_ convo: Conversation, _ message: ChatMessage = ChatMessage(author: "", text: "")) throws -> ChatMessage {
        guard let cid = convo.id else { throw FirebaseError.generic("No Conversation ID found")}
        var convo = convo
        if !message.text.isEmpty {
            convo.chats.append(message)
        }
        let convoRef = firebase.Chats.document(cid)
        try convoRef.setData(from: convo)
        return message
    }
    
    
}