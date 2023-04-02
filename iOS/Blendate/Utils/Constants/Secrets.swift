//
//  Secrets.swift
//  Blendate
//
//  Created by Michael on 11/28/22.
//

import Foundation

struct Secrets {
    static let revenueCat = "appl_HXFpLayPGxmPMaWeKjpzHpOkBKi"
    static let entitlement = "Premium"
}

extension String {
    static let kFCMstring = "fcm"
    static let Yearly_ID = "com.blendate.blendate.yearly"
    static let Monthly_ID = "com.blendate.blendate.monthly"
    static let SemiAnnual_ID = "com.blendate.blendate.semiAnnual"
    static let Lifetime_ID = "com.blendate.blendate.lifeMembership"
    
    static let kOpenString:String = "Open to all"
    static let kEmailKey: String = "kEmailKey"
}

extension String {
    static let PivacyLink = "https://static1.squarespace.com/static/6023169df466f523d92e7d8a/t/60de4876f4d6a473bdb3e84f/1625180278612/2021-06-21+Blendate+Privacy+Policy+v1.docx.pdf"
}

struct CollectionPath {
    static let Users = "users"
    static let Matches = "matches"
    static let Community = "community"
    static let Settings = "settings"
    
    static private let Messages = "messages"
    
    /// /matches/123/messages/
    static func Messages(for cid: String) -> String {
        return Matches + "/\(cid)/" + Messages
    }
    
    // /users/123/likes
    static func Path(swipe: Swipe.Action, uid: String) -> String {
        return CollectionPath.Users + "/\(uid)/\(swipe.rawValue)"
    }
    
    // /users/123/likes_you
    static func Path(swipeYou: Swipe.Action, uid: String) -> String {
        return CollectionPath.Users + "/\(uid)/\(swipeYou.rawValue)_you"
    }
}

