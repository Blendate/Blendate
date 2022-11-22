//
//  Conversation.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Conversation: Codable, Identifiable {
    @DocumentID var id: String?
    var users: [String]
    var lastMessage: ChatMessage = ChatMessage(author: "", text: "")
    let timestamp: Date
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
