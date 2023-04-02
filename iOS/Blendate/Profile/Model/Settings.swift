//
//  Settings.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/15/23.
//

import SwiftUI
import FirebaseFirestoreSwift

extension User {
    struct Settings: Codable {
        @DocumentID var id: String?
        var notifications: Notifications = Notifications()
        var premium: Premium = Premium()
        
        struct Notifications: Codable {
            var fcm: String = ""
            var isOn: Bool = true
            var messages: Bool = true
            var matches: Bool = true
            var likes: Bool = false
        }
    }
}
extension User.Settings: FirestoreObject {
    static let collection = CollectionPath.Settings
}

