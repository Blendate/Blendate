//
//  MessagesViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import Foundation

@MainActor
class MatchesViewModel: FirestoreService<Match> {
    var matches: [Match] {
        fetched
        .filter{$0.lastMessage.isEmpty}
        .sorted{$0.timestamp > $1.timestamp}
    }
    var conversations: [Match] {
        fetched
        .filter{!$0.lastMessage.isEmpty}
        .sorted{$0.timestamp > $1.timestamp}
    }
    
    init(uid: String){
        super.init()
        self.collection
        .whereField("users", arrayContains: uid)
        .addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach{ change in
                guard let object = try? change.document.data(as: Match.self) else {return}
                if change.type == .added {
                    self.fetched.append(object)
                } else if let index = self.fetched.firstIndex(where: {$0.id == object.id}), change.type == .modified {
                    self.fetched[index] = object
                }
            }
        }
    }
}
