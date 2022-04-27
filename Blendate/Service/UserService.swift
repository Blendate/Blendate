//
//  UserService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import FirebaseFirestore

class UserService {

    let Users = FirebaseManager.instance.Users
    let filemanager = LocalFileManager.instance
    
    func updateUser(with user: User) throws {
        let uid = try FirebaseManager.instance.checkUID()
        try filemanager.store(user: user)
        do {
            try Users.document(uid).setData(from: user)
        } catch {
            throw ErrorInfo(errorDescription: "Server Error", failureReason: "There was an error accessing your device's online storage", recoverySuggestion: "Try again")
        }
    }
    

}

// Match Functions
//extension UserService {
//
//    func fetchLineup() async throws -> [User] {
//        guard let uid = FirebaseManager.instance.auth.currentUser?.uid else {return []}
//        var passes: [String] = []
//        var likes: [String] = []
//
//        do {
//            passes = try await FirebaseManager.instance.Passes(for: uid).getDocuments().documents.compactMap { doc in
//                doc.documentID
//            }
//
//        }catch{print("no passses")}
//        do {
//            likes = try await FirebaseManager.instance.Likes(for: uid).getDocuments().documents.compactMap { doc in
//                doc.documentID
//            }
//        } catch {print("no likes")}
//
//        var combine = likes + passes
//        combine = combine.isEmpty ? ["combine"] : combine
//        let snapshot = try await Users
//            .whereField(.documentID(), notIn: combine)
//            .getDocuments()
//
//        let users = snapshot.documents
//            .filter({$0.documentID != uid})
//            .compactMap { document in
//                try? document.data(as: User.self)
//        }
//        return users
//    }
    
    
    
//    func swipe(on swipedUID: String?, _ swipe: Swipe) async throws -> Bool {
//        guard let uid = FirebaseManager.instance.auth.currentUser?.uid,
//                let swipedUID = swipedUID
//            else { throw FirebaseError.generic("Error Swiping on User") }
//        
//        let swipeString = swipe.rawValue
//        try await Users.document(uid).collection(swipeString).document(swipedUID).setData(["timestamp":Date()])//.document(swipedUID).setData()// .setData(from: swipedUser)
//        
//        if swipe == .like {
//        #warning("Always Created a Match")
////        let swipedUserLikes = try await Likes(for: swipedUID).getDocuments().documents.compactMap { doc in
////            doc.documentID
////        }
////        if swipe == .like && swipedUserLikes.contains(uid) {
//            let convoID = FirebaseService.getUsersID(userId1: uid, userId2: swipedUID)
//            let convo = Conversation(id: convoID, users: [swipedUID, uid], chats: [], timestamp: Date())
//            do {
//                let _ = try startConvo(convo)
//                return true
//            } catch {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//    
//    func startConvo(_ convo: Conversation, _ message: ChatMessage = ChatMessage(author: "", text: "")) throws -> ChatMessage {
//        guard let cid = convo.id else { throw FirebaseError.generic("No Conversation ID found")}
//        var convo = convo
//        if !message.text.isEmpty {
//            convo.chats.append(message)
//        }
//        let convoRef = FirebaseManager.instance.Chats.document(cid)
//        try convoRef.setData(from: convo)
//        return message
//    }
        
//}
