//
//  ChatMessage.swift
//  Blendate
//
//  Created by Michael on 8/4/21.
//

import Foundation
import RealmSwift

@objcMembers class ChatMessage: Object, ObjectKeyIdentifiable {
    dynamic var _id = UUID().uuidString
    dynamic var partition = "" // "conversation=<conversation-id>"
    dynamic var author: String? // identifier
    dynamic var text = ""
    dynamic var timestamp = Date()

    override static func primaryKey() -> String? {
        return "_id"
    }
    
    convenience init(author: String, text: String) {
        self.init()
        self.author = author
        self.text = text

    }
    
    var conversationId: String {
        get { partition.components(separatedBy: "=")[1] }
        set(conversationId) { partition = "conversation=\(conversationId)"}
    }
}

extension ChatMessage: Identifiable {
    var id: String { _id }
}

