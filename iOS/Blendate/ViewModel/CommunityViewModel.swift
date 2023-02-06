//
//  CommunityViewModel.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/5/23.
//

import Foundation


class CommunityViewModel: FirebaseService<CommunityTopic> {
    @Published var alert: AlertError?
    
    init(){
        super.init(collection: "community")
    }
    
    
    func newDiscussion(author: String, title: String, description: String) async {
        let topic = CommunityTopic(author: author, title: title, subtitle: description)

        do {
            try create(topic)
        } catch {
            self.alert = AlertError(title: "Server Error", message: "Could not create a new discussion.", recovery: "Try Again")
        }
    }
    
    func sendMessage(to topic: CommunityTopic, message: String, author: String) async throws {
        let chatMessage = ChatMessage(author: author, text: message)

        do {
            let tid = try fid(topic, nil)
            let topicReference = collection.document(tid)
            let messagesReference = topicReference.collection("messages")
            
            try messagesReference.document().setData(from: chatMessage)
            topic.lastMessage = chatMessage
            try update(topic)
        } catch {
            throw AlertError(title: "Server Error", message: "There was an error sending your message.", recovery: "Try Again")
        }
    }
}
