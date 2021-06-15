//
//  Ref.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import Foundation
import Firebase

class Api {
    static var User = UserAPI()
    static var Chat = ChatAPI()
}

class Ref {
    // FIRESTORE
    static let FIRESTORE_ROOT = Firestore.firestore()
    
    // Firestore = User Reference
    static let FIRESTORE_COLLECTION_USERS = FIRESTORE_ROOT.collection("users")
    static func FIRESTORE_DOCUMENT_USERID(_ uid: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_USERS.document(uid)
    }
    
    // STORAGE
    static let STORAGE_ROOT = Storage.storage().reference()
    
    // Storage - Profile
    static let STORAGE_IMAGES = STORAGE_ROOT
    static func STORAGE_PROFILE(uid: String) -> StorageReference {
        return STORAGE_IMAGES.child("\(uid)/profile.jpg")
    }
    static func STORAGE_COVER(uid: String) -> StorageReference {
        return STORAGE_IMAGES.child("\(uid)/cover.jpg")
    }
    static func STORAGE_IMAGES(uid: String, image: Int) -> StorageReference {
        return STORAGE_IMAGES.child("\(uid)/\(image).jpg")
    }
    
    // Firestore - CHATS
    static var FIRESTORE_COLLECTION_CHAT = FIRESTORE_ROOT.collection("chat")
    static func FIRESTORE_COLLECTION_CHATROOM(senderId: String, recipientId: String) -> CollectionReference {
        return FIRESTORE_COLLECTION_CHAT.document(senderId).collection("chatRoom").document(recipientId).collection("chatItems")
    }
    static func FIRESTORE_CHATROOM_DOCUMENT(senderId: String, recipientId: String) -> (sender: DocumentReference, recipient: DocumentReference) {
         return (FIRESTORE_COLLECTION_CHAT.document(senderId),FIRESTORE_COLLECTION_CHAT.document(recipientId))
    }
    
    static var FIRESTORE_COLLECTION_INBOX_MESSAGES = FIRESTORE_ROOT.collection("messages")
    static func FIRESTORE_COLLECTION_INBOX_MESSAGES(userId: String) -> CollectionReference {
        return FIRESTORE_COLLECTION_INBOX_MESSAGES.document(userId).collection("inboxMessages")
    }
    
    static func FIRESTORE_COLLECTION_INBOX_MESSAGES_DOCUMENT_USERID(senderId: String, recipientId: String) -> DocumentReference {
        return FIRESTORE_COLLECTION_INBOX_MESSAGES.document(senderId).collection("inboxMessages").document(recipientId)
    }
}
