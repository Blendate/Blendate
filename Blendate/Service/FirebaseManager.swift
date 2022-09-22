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


class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    let Users: CollectionReference
    let Chats: CollectionReference
    let StorageRef: StorageReference
    
    func Passes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("passes")
    }
    
    func Likes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("likes")
    }
    
    static let instance = FirebaseManager()
    
    private override init(){

//        FirebaseApp.configure()

        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        Users = firestore.collection("users")
        Chats = firestore.collection("chats")
        StorageRef = storage.reference()
        super.init()
    }
    
    static func getUsersID(userId1: String, userId2: String) -> String {userId1 > userId2 ? userId1 + userId2 : userId2 + userId1}
    
    func getProviders() -> [Provider]? {
        guard let user = auth.currentUser else {return nil }
        
        var providers = [Provider]()
        for i in user.providerData {
            printD("Provider: \(i.providerID)\nEmail: \(i.email ?? "None")")
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    providers.append(Provider(type: .apple, email: i.email) )
                case "facebook.com":
                    providers.append(Provider(type: .facebook, email: i.email) )
                case "google.com":
                    providers.append(Provider(type: .google, email: i.email) )
                case "twitter.com":
                    providers.append(Provider(type: .twitter, email: i.email) )
                default:
                    providers.append(Provider(type: .email, email: i.email) )
                }
            }
        }
        return providers
    }
    
    func checkUID() throws -> String {
        guard let uid = auth.currentUser?.uid else {throw FirebaseError.generic("No UID")}
        return uid
    }
    
    func getProvider() -> Provider? {
        guard let user = auth.currentUser else {return nil }

        for i in user.providerData {
            print(i.providerID)
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    return Provider(type: .apple, email: i.email ?? "")
                case "facebook.com":
                    return Provider(type: .facebook, email: i.email ?? "")
                case "google.com":
                    return Provider(type: .google, email: i.email ?? "")
                case "twitter.com":
                    return Provider(type: .twitter, email: i.email ?? "")
                default:
                    return Provider(type: .email, email: i.email ?? "")
                }
            } else {
                return nil
            }
        }
        return nil
    }
    
    func signout(){
        try? auth.signOut()
    }

}


enum FirebaseError: LocalizedError{
    case decode
    case server
    case generic(String)
    
    
    var errorDescription: String? {
        switch self {
        case .decode:
            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
        case .server:
            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
        case .generic(let string):
            return NSLocalizedString(string, comment: "Firebase Error")
        }
    }
    
    var recoverySuggestion: String? {
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
