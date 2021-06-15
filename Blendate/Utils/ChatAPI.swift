//
//  ChatAPI.swift
//  Blendate
//
//  Created by Michael on 5/20/21.
//

import FirebaseAuth
import FirebaseFirestore

class ChatAPI {
    
    func getInboxMessages(onSuccess: @escaping([InboxMessage]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newInboxMessage: @escaping(InboxMessage) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let listenerFirestore = Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES(userId: uid).order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
            guard let snapshot = querySnapshot else {
                return
            }
            
            var inboxMessages = [InboxMessage]()
            
            snapshot.documentChanges.forEach { (documentChange) in
                switch documentChange.type {
                case .added:
                    let dict = documentChange.document.data()
                    guard let decoderInboxMessage = try? InboxMessage(fromDict: dict) else {return}
                    newInboxMessage(decoderInboxMessage)
                    inboxMessages.append(decoderInboxMessage)
                    
                case .modified:
                    print("type: modified")
                case .removed:
                    print("type: removed")
                }
            }
            
            onSuccess(inboxMessages)
            
        }
        
        listener(listenerFirestore)
    }
    
    
}
