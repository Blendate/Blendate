//
//  Conversation.swift
//  Blendate
//
//  Created by Michael on 8/4/21.
//

import Foundation
import RealmSwift

@objcMembers class Conversation: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var unreadCount = 0
    let members = RealmSwift.List<Member>()
    
    convenience init(_ name: String) {
        self.init()
        self.name = name
    }
}

@objcMembers class Member: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var identifier = ""
    dynamic var membershipStatus: String = "User added, but invite pending"
    
    convenience init(_ identifier: String) {
        self.init()
        self.identifier = identifier
        membershipState = .pending
    }
    
    convenience init(identifier: String, state: MembershipStatus) {
        self.init()
        self.identifier = identifier
        membershipState = state
    }
    
    var membershipState: MembershipStatus {
        get { return MembershipStatus(rawValue: membershipStatus) ?? .left }
        set { membershipStatus = newValue.asString }
    }
}


enum MembershipStatus: String {
    case pending = "User added, but invite pending"
    case invited = "User has been invited to join"
    case active = "Membership active"
    case left = "User has left"
    
    var asString: String {
        self.rawValue
    }
}

enum Presence: String {
    case onLine = "On-Line"
    case offLine = "Off-Line"
    case hidden = "Hidden"
    
    var asString: String {
        self.rawValue
    }
}
