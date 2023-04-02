//
//  ChatMessage.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/15/23.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatMessage: Codable, Identifiable {
    @DocumentID var id: String?
    var author: String
    var text: String
    var timestamp: Date

    init(author: String, text: String) {
        self.author = author
        self.text = text
        self.timestamp = Date()
    }
}
