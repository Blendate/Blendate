//
//  CommunityTopic.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import Foundation
import FirebaseFirestoreSwift

struct CommunityTopic: Codable, Identifiable {
    @DocumentID var id: String?
    var users: [String]
    var timestamp: Date = .now
    var lastMessage: String = ""
    
    var title: String
    var subtitle: String
    var author: String
    
    init(author: String, title: String, subtitle: String) {
        self.users = [author]
        self.timestamp = .now
        self.lastMessage = ""
        self.title = title
        self.subtitle = subtitle
        self.author = author
    }
    
}
