//
//  DetailService.swift
//  Blendate
//
//  Created by Michael on 11/21/22.
//

import Foundation

class DetailService: FirebaseService<Details> {
    
    init() { super.init(collection: "details") }

    
    func fetchLineup(for uid: String) async throws -> [Details] {
        let swipeHistory = await allSwipes(for: uid)
        let snapshot = try await collection
            .whereField(.documentID(), notIn: swipeHistory)
            .getDocuments()
        let details = snapshot.documents
            .filter({$0.documentID != uid})
            .compactMap { try? $0.data(as: Details.self) }
        devPrint("Lineup Fetched: \(details.count) Details")
        
        return details
    }
}
