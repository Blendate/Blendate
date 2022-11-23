//
//  Conversation.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class Conversation: Codable, Identifiable {
    @DocumentID var id: String?
    var users: [String]
    let timestamp: Date
    var lastMessage: ChatMessage

    init(user1: String, user2: String) {
        self.id = MessageService.getUsersID(userId1: user1, userId2: user2)
        self.users = [user1, user2]
        self.timestamp = .now
        self.lastMessage = ChatMessage(author: "", text: "")
    }
}

extension Conversation {
    func withUserID(_ uid: String?)->String?{
        guard let uid = uid else {return nil}
        return users.first(where: {$0 != uid})
    }
    //    func latest()->ChatMessage? {
    //        return chats.max(by: {
    //           $0.timestamp < $1.timestamp
    //        })
    //    }
    //
    //    var lastDate: Date {
    //        latest()?.timestamp ?? Date()
    //    }
}

extension Conversation: Equatable {
    static func == (lhs: Conversation, rhs: Conversation) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ChatMessage: Codable, Identifiable {
    @DocumentID var id: String?
    var author: String
    var text = ""
    var timestamp: Date

    init(author: String, text: String) {
        self.author = author
        self.text = text
        self.timestamp = Date()
    }
}

extension ChatMessage {
    var isEmpty: Bool {
        author.isEmpty && text.isEmpty
    }
}
