//
//  MessagesViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import Foundation

@MainActor
class MessagesViewModel: FirestoreService<Conversation> {
    var matches: [Conversation] {
        fetched
        .filter{$0.lastMessage.isEmpty}
        .sorted{$0.timestamp > $1.timestamp}
    }
    var conversations: [Conversation] {
        fetched
        .filter{!$0.lastMessage.isEmpty}
        .sorted{$0.timestamp > $1.timestamp}
    }
    
    init(uid: String){
        super.init(collection: Self.kChats, param: (field: "users", contains: uid))
    }
}
