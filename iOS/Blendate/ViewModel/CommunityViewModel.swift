//
//  CommunityViewModel.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/5/23.
//

import Foundation


class CommunityViewModel: FirestoreService<CommunityTopic> {
    
    init(){
        super.init(listener: true)
    }
    
    func newDiscussion(author: String, title: String, description: String) async {
        do {
            let topic = CommunityTopic(author: author, title: title, subtitle: description)
            try create(topic)
        } catch {
            self.alert = AlertError(title: "Server Error", message: "Could not create a new discussion.", recovery: "Try Again")
        }
    }
    
    func sendMessage(to topic: CommunityTopic, message: String, author: String) async throws {
        do {
            let chatMessage = ChatMessage(author: author, text: message)
            try Self.Messages(for: topic).document().setData(from: chatMessage)
            topic.lastMessage = chatMessage
            try update(topic)
        } catch {
            throw AlertError(title: "Server Error", message: "There was an error sending your message.", recovery: "Try Again")
        }
    }
}
