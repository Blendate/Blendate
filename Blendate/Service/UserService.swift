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
    
    func fetchUser(from uid: String?) async throws -> User {
        guard let uid = uid else { throw FirebaseError.generic("No UID")}
        
        let document = try await Users.document(uid).getDocument()
        if let user = try document.data(as: User.self) {
            var cache = user
            if let prov = FirebaseManager.instance.getProvider(),
               !cache.settings.providers.contains(prov) {
                cache.settings.providers.append(prov)
            }
            return cache
        }
        else { throw FirebaseError.decode }
    }

}
