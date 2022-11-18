//
//  MessagesViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import Foundation

@MainActor
class MessagesViewModel: ObservableObject {
    @Published var allConvos = [Conversation]()
    
    var conversations: [Conversation] {
        allConvos.filter({ $0.lastMessage != nil }).sorted(by: {$0.lastDate > $1.lastDate})
    }
    
    var matches: [Conversation] {
        allConvos.filter({ $0.lastMessage == nil })
    }

    init(){
        fetchConvos()
    }
    
    private func fetchConvos(){
        guard let uid = try? FirebaseManager.instance.checkUID() else {return}
        FirebaseManager.instance.Chats
            .whereField("users", arrayContains: uid)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Fetch Convo Error: \(error.localizedDescription)")
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        if let convo = try? change.document.data(as: Conversation.self) {
                            self.allConvos.append(convo)
                        }
                    } else if change.type == .modified {
                        if let convo = try? change.document.data(as: Conversation.self) {
                            if let index = self.allConvos.firstIndex(where: {$0.id == convo.id}) {
                                self.allConvos[index] = convo
                            }
                        }

                    }
                    print("Fetched \(self.conversations.count) Conversations")
                    print("Fetched \(self.matches.count) Matches")

                })
            }
    }
}
