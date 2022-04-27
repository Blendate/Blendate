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
    
    @Published var withUser: User?
    
    let convo: Conversation
    
    private let chatCollection = "chats"
    
    init(convo: Conversation){
        self.convo = convo
        DispatchQueue.main.async {
            self.count += 1
        }
        fetchMessages()
    }
    
    
    private func fetchMessages(){
        printD("Fetching Messages")
        let firebase = FirebaseManager.instance
        guard let fromID = firebase.auth.currentUser?.uid else {return}
        guard let toID = convo.users.first(where: {$0 != fromID}) else {return}
        let cid = FirebaseManager.getUsersID(userId1: fromID, userId2: toID)
        firebase.Chats.document(cid)
            .collection(chatCollection)
            .order(by: "timestamp")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    printD(error.localizedDescription)
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    printD("In Chat Doc: \(change.document.documentID)")
                    if change.type == .added {
                        if let message = try? change.document.data(as: ChatMessage.self){
                            self.chatMessages.append(message)
                            print(self.chatMessages.count)
                        } else {
                            printD("Decode Error For: \(change.document.documentID)")
                        }
                    }
                })
            }
    }
    
    func fetchUser(){
        let uid = FirebaseManager.instance.auth.currentUser?.uid
        
        Task{
            let user = try await FirebaseManager.instance.fetchUser(from: convo.withUserID(uid))
            DispatchQueue.main.async {
                self.withUser = user
            }
        }

    }
    
    func sendMessageCollection() {
        guard let uid = FirebaseManager.instance.auth.currentUser?.uid else {return}
        guard let cid = convo.id else {return}

//        let chatMessage = ChatMessage(author: uid, text: text)
        let document = FirebaseManager.instance.Chats.document(cid)
            .collection(chatCollection)
            .document()
        let chatMessage = ChatMessage(author: uid, text: text)
        do {
            try document.setData(from: chatMessage)
        } catch {
            printD(error.localizedDescription)
        }
        recentOnConvo(chatMessage.text)
        
        self.text = ""
        self.count += 1

    }
    
    private func recentOnConvo(_ message: String){
        guard let cid = convo.id else {return}
        let document = FirebaseManager.instance.Chats.document(cid)
        document.updateData(["lastMessage":message])
    }
}

