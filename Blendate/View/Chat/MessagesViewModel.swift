//
//  MessageViewModel.swift
//  Blendate
//
//  Created by Michael on 5/20/21.
//

import SwiftUI
import FirebaseFirestore


class MessagesViewModel: ObservableObject {
    @Binding var user: User
    @Published var inboxMessages: [InboxMessage] = []
    
    var listener: ListenerRegistration!

    init(_ user: Binding<User>){
        self._user = user
        loadInboxMessages()
    }
    
    func loadInboxMessages() {
        self.inboxMessages = []
        
        Api.Chat.getInboxMessages(onSuccess: { (inboxMessages) in
            if self.inboxMessages.isEmpty {
                self.inboxMessages = inboxMessages
            }
        }, onError: { (errorMessage) in
            
        }, newInboxMessage: { (inboxMessage) in
            if !self.inboxMessages.isEmpty {
                self.inboxMessages.append(inboxMessage)
            }
        }) { (listener) in
            self.listener = listener
        }
    }
    
}
