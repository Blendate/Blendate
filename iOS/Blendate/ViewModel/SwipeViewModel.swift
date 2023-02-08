//
//  MatchViewModel.swift
//  Blendate
//
//  Created by Michael on 3/31/22.
//

import SwiftUI

@MainActor
class SwipeViewModel: FirestoreService<User> {
    
    @Published var lineup: [User] = []
    @Published var loading = true
    @Published var likedyou: [User] = []
    private let uid: String
    
    init(_ uid: String){
        self.uid = uid
        super.init()
    }
    
    #warning("fix this to only 10")
    @MainActor
    func fetchLineup() async {
        let swipeHistory = await allSwipes(for: uid)
        
        do {
            let snapshot = try await collection.getDocuments().documents

            self.lineup = snapshot
                        .filter{ !swipeHistory.contains($0.documentID) && $0.documentID != uid }
                        .compactMap { try? $0.data(as: User.self) }
//            
//            self.likedyou = snapshot
//                            .filter{ documentSnapshot in
//                                let fid = documentSnapshot.documentID
//                                let likes = await Self.getHistory(for: fid, .like)
//                                let superLikes = await Self.getHistory(for: fid, .superLike)
//                                let allLikes = likes + superLikes
//                                return allLikes.contains(uid)
//                            }
//                            .compactMap { try? $0.data(as: User.self) }

            
            withAnimation(.spring()) {
                loading = false
            }
            print("Fetched Lineup: \(lineup.count)")
        } catch {
            withAnimation(.spring()) {
                loading = false
            }
            print("Lineup", error)
        }
    }

    @MainActor
    func swipe(on match: String, _ swipe: Swipe) async -> Bool  {
        do {
            try await Self.Swipes(for: uid, swipe)
                .document(match)
                .setData(["timestamp":Date()])
            
            print("Swiped \(swipe.rawValue.capitalized) on \(match)")
            return await isMatch(match, swipe)
        } catch {
            self.alert = AlertError(title: "Server Error", message: "Could not save your swipe on the Blendate server.", recovery: "Try Again")
            return false
        }
    }
    
    private func isMatch(_ match: String, _ swipe: Swipe)async->Bool {
        return swipe == .superLike
        guard swipe != .pass else {return false}
        let likes = await getHistory(for: match, .like)
        let superLikes = await getHistory(for: match, .superLike)
        let allLikes = likes + superLikes
        return allLikes.contains(uid)
    }
    

}
//@MainActor
//func createConvo(with match: String) async {
//        let cid = FireStore.getUsersID(userId1: match, userId2: uid)
//        var convo = Match(user1: match, user2: uid)
//        let chats = Matches
//        do {
//            try chats.document(cid).setData(from: convo)
//            convo.id = cid
//            self.newConvo = convo
//        } catch {
//            self.alert = AlertError(title: "Server Error", message: "Could not create your match on the Blendate server.")
//        }
//}
