//
//  User.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Settings: Codable, Identifiable  {
    @DocumentID var id: String?
    var notifications = Notifications(fcm: "", isOn: false)
}

struct Notifications: Codable {
    var fcm: String
    var isOn: Bool
    var messages: Bool = true
    var matches: Bool = true
}
