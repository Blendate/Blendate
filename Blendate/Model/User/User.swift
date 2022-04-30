//
//  User.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return rhs.id == lhs.id
    }
    @DocumentID var id: String?
    
    var details = Details()
    var filters = Filters(.filter)
    var settings = UserSettings()
    
    var fcm: String = ""
}

