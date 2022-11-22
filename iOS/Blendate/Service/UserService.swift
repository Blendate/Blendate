//
//  UserService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseEmailAuthUI

import SwiftUI


class UserService: FirebaseService<User> {

    init() { super.init(collection: "users") }
    
    func update(fcm: String, for uid: String? = nil) {
        guard let uid = uid else { return }
        collection.document(uid).updateData(["fcm":fcm])
        devPrint("Updated FCM for \(uid)")
        print("\t[FCM] \(fcm)")
    }
    
    func fetchLineup(for uid: String) async throws -> [User] {
        let swipeHistory = await allSwipes(for: uid)
        let snapshot = try await collection
            .whereField(.documentID(), notIn: swipeHistory)
            .getDocuments()
        let users = snapshot.documents
            .filter({$0.documentID != uid})
            .compactMap { try? $0.data(as: User.self) }
        devPrint("Lineup Fetched: \(users.count) users")
        
        return users
    }
    

}
