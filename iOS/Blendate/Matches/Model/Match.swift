//
//  Match.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import FirebaseFirestoreSwift

class Match: Codable {

    @DocumentID var id: String?
    
    var users: [String]
    var timestamp: Date = .now
    var lastMessage: ChatMessage? = nil
    
    init(_ uid1: String, _ uid2: String, lastMessage: ChatMessage? = nil) {
        self.users = [uid1, uid2]
        self.lastMessage = lastMessage
    }
    
    init(_ users: [String], lastMessage: ChatMessage? = nil) {
        self.users = users
        self.lastMessage = lastMessage
    }
}

extension Match: Identifiable, Equatable {
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
    }
    
    var conversation: Bool { lastMessage != nil }
}

//extension Match: FirestoreObject {
//    static let collection = CollectionPath.Matches
//}
//extension Match {
//    func withUserID(_ uid: String?)->String?{
//        guard let uid = uid else {return nil}
//        return FireStore.withUserID(users, uid)
//    }
//}
