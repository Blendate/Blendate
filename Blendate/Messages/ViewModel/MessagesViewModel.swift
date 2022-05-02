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
        return self.allConvos.filter({ !$0.lastMessage.isEmpty })
    }
    var matches: [Conversation] {
        return self.allConvos.filter({ $0.lastMessage.isEmpty })
    }
    
    init(){
        fetchConvos()
    }
    
    private func fetchConvos(){
        guard let uid = FirebaseManager.instance.auth.currentUser?.uid else {return}
        FirebaseManager.instance.Chats
            .whereField("users", arrayContains: uid)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    printD(error.localizedDescription)
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        if let convo = try? change.document.data(as: Conversation.self) {
                            self.allConvos.append(convo)

                        }
                    }
                    else if change.type == .modified {
                        if let convo = try? change.document.data(as: Conversation.self) {
                            if let index = self.allConvos.firstIndex(where: {$0.id == convo.id}) {
                                self.allConvos[index] = convo
                            }
                        }

                    }
                })
            }
    }
}
