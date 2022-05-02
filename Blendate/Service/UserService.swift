//
//  UserService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import FirebaseFirestore
import SwiftUI

class UserService {

    let Users = FirebaseManager.instance.Users
    let filemanager = LocalFileService.instance
    
    func updateUser(with user: User) throws {
        let uid = try FirebaseManager.instance.checkUID()
        try? filemanager.store(user: user)
        do {
            try Users.document(uid).setData(from: user)
        } catch {
            throw ErrorInfo(errorDescription: "Server Error", failureReason: "There was an error accessing your device's online storage", recoverySuggestion: "Try again")
        }
    }
    
    func update(fcm: String) {
        if let uid = try? FirebaseManager.instance.checkUID() {
            Users.document(uid).updateData(["fcm":fcm])
        }  else {
            printD("Tried to set FCM but no UID")
        }
    }
    
    func fetchUser(from uid: String?) async throws -> User {
        guard let uid = uid else { throw FirebaseError.generic("No UID")}
        
        let document = try await Users.document(uid).getDocument()
        if let user = try document.data(as: User.self) {
            var cache = user
            if let prov = FirebaseManager.instance.getProvider(),
               !cache.settings.providers.contains(prov) {
                cache.settings.providers.append(prov)
            }
            cache.details.photos = cache.details.photos.sorted(by: {$0.placement < $1.placement})
            print(cache.fcm)
            return cache
        }
        else { throw FirebaseError.decode }
    }

}
