//
//  FirestoreObject.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/23.
//

import Foundation
import FirebaseFirestore

class FireStore: NSObject {
    let firestore: Firestore
    
    static let instance = FireStore()
    
    private override init(){
        self.firestore = Firestore.firestore()
        super.init()
    }
    
    static func getUsersID(userId1: String, userId2: String) -> String {
        userId1 > userId2 ? userId1 + userId2 : userId2 + userId1
    }
}

protocol FirestoreObject: Codable, Identifiable {
//    init(_ fid: String)
    var id: String? {get set}
    static var collection: CollectionReference {get}
    static var firestore: Firestore {get}
}

extension FirestoreObject {
    
    static var kUsers: String { "mock_users" }
    static var kMatches: String { "matches" }
    static var kCommunity: String { "community" }
    static var kSettings: String { "settings" }
    static var kMessages: String { "messages" }
    static var firestore: Firestore{ FireStore.instance.firestore }
}

extension User {
    static var collection: CollectionReference { firestore.collection(kUsers) }

}
extension User.Settings {
    static var collection: CollectionReference { firestore.collection(kSettings) }
}

extension Match {
    static var collection: CollectionReference { firestore.collection(kMatches) }
}

extension CommunityTopic {
    static var collection: CollectionReference { firestore.collection(kCommunity) }
}

extension ChatMessage {
    static var collection: CollectionReference { firestore.collection(kMessages) }
}

extension Convo {
    static func messages(for fid: String) -> CollectionReference {
        let parent = Self.self == Match.self ? Match.collection : CommunityTopic.collection
        return parent.document(fid).collection(Self.kMessages)
    }
}

extension FirestoreService {
    
    static func Swipes(for uid: String, _ swipe: Swipe) -> CollectionReference {
        return User.collection.document(uid).collection(swipe.rawValue)
    }
    
//    static func Collection<C:Convo>(for convo: C) -> CollectionReference {
//        return C.self == Match.self ? Match.collection : CommunityTopic.collection
//    }
//
//    static func Messages<C:Convo>(for convo: C) -> CollectionReference {
//        let collection = Collection(for: convo)
//        #warning("fix the optional")
//        let fid = convo.id!
//        return collection.document(fid).collection("chats")
//    }
//
//
    
}
