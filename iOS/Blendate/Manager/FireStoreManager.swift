//
//  FireStore.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/15/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


// MARK: Functions Throw ErrorAlert.Firebase
class FireStore: NSObject {
    let firestore: Firestore
    
    static let instance = FireStore()
    
    private override init(){
        self.firestore = Firestore.firestore()
        super.init()
    }
}

extension FireStore {
    func fetch(uid: String) async throws -> User {
        let collection = firestore.collection(CollectionPath.Users)
        let document = try await collection.document(uid).getDocument()
        let user = try document.data(as: User.self)
        return user
    }
}

extension FireStore {
    
    func swipe(_ swipe: Swipe.Action, on fid: String, from uid: String, message: ChatMessage? = nil) async throws -> Match? {
        guard swipe != .pass else {
            try setSwipes(uid: uid, swiped: swipe, on: fid)
            return nil
        }
        
        let withUserLikeHistory = try await getHistory(for: fid, swipes: [.like, .superLike])
        try setSwipes(uid: uid, swiped: swipe, on: fid)
        
        let mid = FireStore.getUsersID(userId1: uid, userId2: fid)
        let match = Match(uid, fid)
        
        if let message {
            try create(match: match, mid: mid)
            print("[Swipe] Swipe has message, sending...")
            try sendMessage(message, to: mid)
            match.id = mid
            return match
        }
        
        guard withUserLikeHistory.contains(uid) else {
            print("\(fid) has not previously liked \(uid)")
            return nil
        }
        
        print("\(fid) previously liked \(uid)")
        try create(match: match, mid: mid)
        match.id = mid
        return match
    }
    
    private func create(match: Match, mid: String) throws {
        let collection = firestore.collection(CollectionPath.Users)
        try collection.document(mid).setData(from: match)
    }

    func sendMessage(_ chatMessage: ChatMessage, to cid: String) throws {
        let path = CollectionPath.Messages(for: cid)
        let collection = firestore.collection(path)
        do {
            try collection.document().setData(from: chatMessage)
            ///  written as dictionary because firebase wont acceopt the collection.set(from: T) method
            let dict: [String:Any] = [
                "author":chatMessage.author,
                "text":chatMessage.text,
                "timestamp": chatMessage.timestamp
            ]
            
            collection.parent?.updateData(["lastMessage":dict])
            print("Sent Message from \(chatMessage.author)")
        } catch {
            print(error.localizedDescription)
            throw Error.SendMessage
        }
    }
}

extension FireStore {
    
    private func setSwipes(uid: String, swiped: Swipe.Action, on fid: String) throws {
        let path = CollectionPath.Path(swipe: swiped, uid: uid)
        let toUserPath = CollectionPath.Path(swipeYou: swiped, uid: fid)
        
        let collection = firestore.collection(path)
        let toUserCollection = firestore.collection(toUserPath)
        
        do {
            try collection.document(fid).setData(from: Swipe(swiped) )
            try toUserCollection.document(uid).setData(from: Swipe(swiped) )
            print("[Swipe] \(uid) \(swiped.rawValue) \(fid)")
        } catch {
            print(error.localizedDescription)
            throw Error.SetSwipes
        }
    }
}

// MARK: - Private Helpers
extension FireStore {
    private func fetch(who swiped: Swipe.Action, uid: String) async throws -> [String] {
        do {
            let path = CollectionPath.Path(swipeYou: swiped, uid: uid)
            let documents = try await firestore.collection(path).getDocuments().documents
            return documents.map{$0.documentID}
        } catch {
            print(error.localizedDescription)
            throw Error.GetBlends
        }
    }
    
    private func fetch(swipes: Swipe.Action, of uid: String) async throws -> [String] {
        do {
            let path = CollectionPath.Path(swipe: swipes, uid: uid)
            let documents = try await firestore.collection(path).getDocuments().documents
            return documents.compactMap{$0.documentID}
        } catch {
            throw Error.GetBlends
        }
    }
    
    func getHistory(for uid: String, swipes: [Swipe.Action] = Swipe.Action.allCases) async throws -> [String] {
        var all = [String]()
        for swipe in swipes {
            let history = try await fetch(swipes: swipe, of: uid)
            all.append(contentsOf: history)
        }
        print("[SwipeHistory] \(uid) \(all.count) swipes")
        return all
    }
}

extension FireStore {
    
    static func getUsersID(userId1: String, userId2: String) -> String {
        userId1 > userId2 ? userId1 + userId2 : userId2 + userId1
    }
    
    static func withUserID(_ users: [String], _ uid: String)->String?{
        return users.first(where: {$0 != uid})
    }
}



extension FireStore {
    struct Error: ErrorAlert {
        var title = "Server Error"
        var message: String = ""

        static let noID = Error(message: "The Object is missing a server ID")
        static let SetSwipes = Error(message: "There was an error saving the Blend on the FireStore server")
        static let SendMessage = Error(message:"There was an error sending your message to the FireStore server")
        static let GetBlends = Error(message: "There was an error getting your previous Likes from the FireStore server")
    }
}
