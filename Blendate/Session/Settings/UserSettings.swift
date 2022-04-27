//
//  Settings.swift
//  Blendate
//
//  Created by Michael on 1/21/22.
//

import Foundation

struct UserSettings: Codable {
    var premium: Bool = false
    var notifications: Bool = true
    var invisbleBlending: Bool = false
    var providers: [Provider] = []
    var onboarded = false
    var hideAge: Bool = false
    
    var dev: Dev? = Dev()
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



enum AuthType: String, Codable, Identifiable, Hashable, CaseIterable {
    var id: String {self.rawValue}
    case apple = "Apple"
    case google = "Google"
    case facebook = "Facebook"
    case twitter = "Twitter"
    case email = "Email"
}


struct Dev: Codable {
    var classicTab = false
}
