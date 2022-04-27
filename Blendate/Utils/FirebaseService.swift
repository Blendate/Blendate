//
//  FirebaseService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

//class FirebaseService {
//    let db = Firestore.firestore()
//    let auth = Auth.auth()
//    let Users: CollectionReference
//    let Chats: CollectionReference
////    let Matches: CollectionReference
//
//    static let instance = FirebaseService()
//
//    private init(){
//        Users = db.collection("users")
//        Chats = db.collection("chats")
////        Matches = db.collection("matches")
//    }
//
//    func signout() throws {
//        try auth.signOut()
//    }
//
//    func Passes(for uid: String) -> CollectionReference {
//        return Users.document(uid).collection("passes")
//    }
//
//    func Likes(for uid: String) -> CollectionReference {
//        return Users.document(uid).collection("likes")
//    }
//
//    static func getUsersID(userId1: String, userId2: String) -> String {userId1 > userId2 ? userId1 + userId2 : userId2 + userId1}
//
//    func checkUID() throws -> String {
//        guard let uid = auth.currentUser?.uid else {throw FirebaseError.generic("No UID")}
//        return uid
//    }
//
//}

public enum FirebaseError: Error, LocalizedError, Identifiable{
    case decode
    case server
    case generic(String)
    
    public var id: String {self.localizedDescription}
    
    public var errorDescription: String? {
        switch self {
        case .decode:
            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
        case .server:
            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
        case .generic(let string):
            return NSLocalizedString(string, comment: "Firebase Error")
        }
    }
}


class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    let Users: CollectionReference
    let Chats: CollectionReference
    
    func Passes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("passes")
    }
    
    func Likes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("likes")
    }
    
    static let instance = FirebaseManager()
    
    private override init(){

        FirebaseApp.configure()

        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        Users = firestore.collection("users")
        Chats = firestore.collection("chats")
        super.init()
    }
    
    static func getUsersID(userId1: String, userId2: String) -> String {userId1 > userId2 ? userId1 + userId2 : userId2 + userId1}
    
    func fetchUser(from uid: String?) async throws -> User {
        guard let uid = uid else { throw FirebaseError.generic("No UID")}
        
        let document = try await Users.document(uid).getDocument()
        if let user = try document.data(as: User.self) {
            return user
        }
        else { throw FirebaseError.decode }
    }
    
    func checkUID() throws -> String {
        guard let uid = auth.currentUser?.uid else {throw FirebaseError.generic("No UID")}
        return uid
    }

}
