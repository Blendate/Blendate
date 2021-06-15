//
//  Chat.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import Foundation
import FirebaseAuth

struct Chat: Encodable, Decodable {
    var messageId: String
    var text: String
    var senderId: String
    var receiverId: String
    var date: Double
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser!.uid == senderId
    }
}

struct InboxMessage: Encodable, Decodable, Identifiable {
    var id = UUID()
    var lastMessage: String // messageID
    var uid: String
    var name: String
    var avatarUrl: String
    var date: Double
}

class Convo: Identifiable {
    var id = UUID().uuidString
    var date: Date = Date()
}
