//
//  DetailService.swift
//  Blendate
//
//  Created by Michael on 11/21/22.
//

import Foundation

class UserService: FirebaseService<User> {
    
    init() { super.init(collection: "users") }
    
    func fetchLineup(for uid: String) async throws -> [User] {
        devPrint("Fetching Lineup for \(uid)")
        let swipeHistory = await allSwipes(for: uid)
        let snapshot = try await collection
            .whereField(.documentID(), notIn: swipeHistory)
            .getDocuments()
        let details = snapshot.documents
            .filter({$0.documentID != uid})
            .compactMap { try? $0.data(as: User.self) }
        devPrint("Lineup Fetched: \(details.count) Users")
        return details
    }
}
