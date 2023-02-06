//
//  DetailService.swift
//  Blendate
//
//  Created by Michael on 11/21/22.
//

import Foundation

class UserService: FirebaseService<User> {
    
    init() { super.init(collection: Self.kUsers) }
    
    func fetchLineup(for uid: String) async throws -> [User] {
        devPrint("Fetching Lineup for \(uid)")
        let swipeHistory = await allSwipes(for: uid)
        #warning("fix this to not only 10")
//        let snapshot = try await collection
//            .whereField(.documentID(), notIn: swipeHistory)
//            .getDocuments()
        let snapshot = try await collection.getDocuments().documents
            .filter({ snapshot in
                !swipeHistory.contains(snapshot.documentID) && snapshot.documentID != uid
            })
        do {
            let details = try snapshot
                .compactMap { try $0.data(as: User.self) }
            devPrint("Lineup Fetched: \(details.count) Users")
            return details
        } catch {
            print(error)
            return []
        }

    }
}
