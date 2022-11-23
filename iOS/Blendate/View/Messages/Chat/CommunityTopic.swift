//
//  CommunityTopic.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import Foundation
import FirebaseFirestoreSwift

class CommunityTopic: Codable, Identifiable {
    @DocumentID var id: String?
    var users: [String]
    let timestamp: Date
    var lastMessage: ChatMessage
    
    let title: String
    let subtitle: String
    let author: String
    
    init(id: String, title: String, subtitle: String, author: String) {
        self.id = id
        self.users = [author]
        self.timestamp = .now
        self.lastMessage = ChatMessage(author: "", text: "")
        self.title = title
        self.subtitle = subtitle
        self.author = author
    }
    
}
