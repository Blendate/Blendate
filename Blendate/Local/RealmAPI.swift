////
////  RealmAPI.swift
////  Blendate
////
////  Created by Michael on 7/22/21.
////
//
//import Foundation
//import RealmSwift
//import SwiftUI
//import Realm
//
//class RealmAPI {
//    
//    
//    static func addDocument(rlm: RLMUser, user: AppUser,
//                             onSuccess: @escaping()->Void,
//                             onError: @escaping(_ errorMessage: String)->Void) {
//        
//            let realm = try! Realm(configuration: rlm.configuration(partitionValue: "date"))
//            if let id = try? ObjectId(string: rlm.id) {
//                user._id = id
//                try? realm.write {
//                    realm.add(user)
//                    onSuccess()
//                }
//            }
//
//
//
////        let db = rlm.mongoClient("mongodb-atlas").database(named: "all_users")
////        let collection = db.collection(withName: "User")
////        let dict = user.toDict()
////        collection.insertOne(["_id":"23125524232323", "bio":"testing"]) { (result) in
////            switch result {
////            case .failure(let error):
////                app.currentUser?.logOut()
////                onError("Failed to insert document: \(error.localizedDescription)")
////            case .success(let newObjectId):
////                print("Inserted custom user data document with object ID: \(newObjectId)")
////                onSuccess()
////            }
////        }
//
//    }
//    
//    static func loginAnon(user: AppUser, onSuccess: @escaping()->Void,
//                          onError: @escaping(_ errorMessage: String)->Void) {
//        user.realm_id = "date"
//        app.login(credentials: Credentials.anonymous) { (result) in
//            switch result {
//            case .failure(let error):
//                onError("Failed to log in: \(error.localizedDescription)")
//            case .success(let userRLM):
//                print(userRLM.id)
//                addDocument(rlm: userRLM, user: user, onSuccess: onSuccess, onError: onError)
//            }
//        }
//    }
//    
//    static func loginEmail(email: String, password: String, user: AppUser, onSuccess: @escaping()->Void,
//                          onError: @escaping(_ errorMessage: String)->Void) {
//        
//        app.login(credentials: Credentials.emailPassword(email: email, password: password)) { (result) in
//            switch result {
//            case .failure(let error):
//                onError("Failed to log in: \(error.localizedDescription)")
//            case .success(let userRLM):
//                print(userRLM.id)
//                addDocument(rlm: userRLM, user: user, onSuccess: onSuccess, onError: onError)
//            }
//        }
//    }
//    
//    
//    static func logout(onSuccess: @escaping()->Void, onError: @escaping(_ errorMessage: String)->Void) {
//        app.currentUser?.logOut(completion: { error in
//            if let err = error {
//                onError(err.localizedDescription)
//            } else {
//                onSuccess()
//            }
//        })
//        
//    }
//}
