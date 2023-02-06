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
    var superLikes: Int = 0
    var premium: Premium = Premium()
}

struct Notifications: Codable {
    var fcm: String
    var isOn: Bool
    var messages: Bool = true
    var matches: Bool = true
    var likes: Bool = false
}

struct Premium: Codable {
    var invisbleBlending: Bool = false
    var hideAge: Bool = false
    var color: Color = .Blue
}

extension Premium {
    
    static let Access: [Detail] = [.childrenRange, .height, .politics, .mobility, .vices]
}
