//
//  Settings.swift
//  Blendate
//
//  Created by Michael on 1/21/22.
//

import Foundation

struct UserSettings: Codable {
    var premium: Bool = false
    var notifications = Notifications(isOn: false)
    var invisbleBlending: Bool = false
    var providers: [Provider] = []
    var onboarded = false
    var hideAge: Bool = false
}

struct Provider: Codable, Identifiable, Equatable{
    var id: String {type.rawValue}
    let type: AuthType
    var email: String
    
    init(type: AuthType, email: String? = nil){
        self.type = type
        self.email = email ?? ""
    }
}

struct Notifications: Codable {
    var messages: Bool = true
    var matches: Bool = true
    
    var isOn: Bool
    var fcm: String = ""

}



enum AuthType: String, Codable, Identifiable, Hashable, CaseIterable {
    var id: String {self.rawValue}
    case apple = "Apple"
    case google = "Google"
    case facebook = "Facebook"
    case twitter = "Twitter"
    case email = "Email"
}
