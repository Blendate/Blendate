//
//  ChatViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import Foundation

@MainActor
class ChatViewModel: ObservableObject {
    
    @Published var text: String = ""
    @Published var chatMessages = [ChatMessage]()
    @Published var count = 0
    
    let convo: Conversation
    
    let service = MessageService()
    let firebase = FirebaseManager.instance

        
    init(convo: Conversation){
        self.convo = convo
        self.count += 1
        fetchMessages()
    }
    
    private func fetchMessages(){
        printD("Fetching Messages")
        guard let fromID = try? firebase.checkUID() else {return}
        guard let toID = convo.users.first(where: {$0 != fromID}) else {return}
        
        let cid = FirebaseManager.getUsersID(userId1: fromID, userId2: toID)
        firebase.Chats.document(cid)
            .collection("chats")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard error == nil else {
                    printD(error!.localizedDescription)
                    return
                }
 
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        if let message = try? change.document.data(as: ChatMessage.self){
                            self.chatMessages.append(message)
                        } else {
                            printD("Decode Error For: \(change.document.documentID)")
                        }
                    }
                })
            }
    }
    
    func sendMessage() async {
        do {
            try await service.sendMessage(conversationID: convo.id, message: text)
            self.text = ""
            self.count += 1
        } catch {
            printD(error.localizedDescription)
        }
    }

}

