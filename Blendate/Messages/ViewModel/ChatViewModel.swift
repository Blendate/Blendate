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
    
    let cid: String?
    
    let service = MessageService()

        
    init(cid: String?){
        self.cid = cid
        self.count += 1
        fetchMessages()
    }
    
    private func fetchMessages(){
        guard let cid = self.cid else {return}
        print("Fetching Messages for Convo ID: \(cid)")
        FirebaseManager.instance.Chats.document(cid)
            .collection("chats")
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                guard error == nil else {
                    print("Fetch Messages Error: \(error?.localizedDescription)")
                    return
                }
 
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        if let message = try? change.document.data(as: ChatMessage.self){
                            self.chatMessages.append(message)
                        } else {
                            print("Decode Error For: \(change.document.documentID)")
                        }
                    }
                })
            }
    }
    
    func sendMessage() async {
        guard let cid = cid else {return}
        do {
            try await service.sendMessage(conversationID: cid, message: text)
            self.text = ""
            self.count += 1
        } catch {
            print("Send Message Error: \(error.localizedDescription)")
        }
    }

}
