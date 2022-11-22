//
//  User.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User {
    @DocumentID var id: String?
//    var details = Details()
//    var filters = Stats(.filter)
    var settings = UserSettings()
    
    var fcm: String = ""
}

extension User: Codable, Identifiable {}
