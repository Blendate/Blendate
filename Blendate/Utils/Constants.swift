//
//  Constants.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import Foundation
import SwiftUI
import UIKit

class Dummy {
    static let user: User = {
        var user = User(id: "")
        user.firstName = "Jacob"
        user.lastName = "Cooper"
        user.birthday = Date()
        user.gender = .male
        user.isParent = true
        user.children = 3
        user.childrenAge = IntRange(min: 0, max: 4)
        
        user.location = "New York"
        user.bio = "Hi, I’m Jacob! I have 2 kids, Sarah and Josh. I love walking on the beach and playing tennis 🎾"
        
        
        user.relationship = .divorced
        user.height = 160
        user.seeking = .female
        user.familyPlans = .dontCare
        user.religion = .jewish
        user.politics = .centrist
        user.ethnicity = .middleEast
        user.hometown = "Williamsburg"
        user.images = [:]
        user.profileImage = "https://firebasestorage.googleapis.com/v0/b/blendate-fb2b6.appspot.com/o/c1kITJXJiGcBUEYNhz4a19ALzwC2%2Fprofile.jpg?alt=media&token=23ebb520-6ce8-4067-b045-c280c936de13"
        user.coverPhoto = "https://firebasestorage.googleapis.com/v0/b/blendate-fb2b6.appspot.com/o/c1kITJXJiGcBUEYNhz4a19ALzwC2%2Fcover.jpg?alt=media&token=0a6fc352-eed2-4556-98d9-d113b505e19b"
        user.interests = ["Technology", "Sports", "Fitness", "Cooking", "Food", "Words", "Animals", "Health"]
        
        return user
    }()
    
    static let user2: User = {
        var user = User(id: "")
        user.firstName = "Michael"
        user.lastName = "Dabiels"
        user.birthday = Date()
        user.gender = .male
        user.isParent = false
        
        user.location = "Brooklyn"
        user.bio = "Hi, I’m Mike! I dont have kids but looking to start a family, I love tennis 🎾"
        
        
        user.relationship = .single
        user.height = 180
        user.seeking = .female
        user.familyPlans = .dontCare
        user.religion = .jewish
        user.politics = .liberal
        user.ethnicity = .middleEast
        user.hometown = "Williamsburg"
        user.images = [:]
        user.profileImage = "https://firebasestorage.googleapis.com/v0/b/blendate-fb2b6.appspot.com/o/c1kITJXJiGcBUEYNhz4a19ALzwC2%2Fprofile.jpg?alt=media&token=23ebb520-6ce8-4067-b045-c280c936de13"
        user.coverPhoto = "https://firebasestorage.googleapis.com/v0/b/blendate-fb2b6.appspot.com/o/c1kITJXJiGcBUEYNhz4a19ALzwC2%2Fcover.jpg?alt=media&token=0a6fc352-eed2-4556-98d9-d113b505e19b"
        user.interests = ["Technology", "Sports", "Fitness", "Cooking", "Food", "Words", "Animals", "Health"]
        
        return user
    }()
    
    static let inbox: InboxMessage =
        InboxMessage(
            id: UUID(),
            lastMessage: "Before you start making connections",
            uid: "",
            name: "Team Blendate",
            avatarUrl: "",
            date: 1.2
        )
    
    static let chats: [Chat] = [
        
    
    
    ]
    
}

let ColorGradient = LinearGradient(gradient: Gradient(colors: [Color("Pink"), Color("Blue")]), startPoint: .bottomTrailing, endPoint: .topLeading)

extension Color {
    static let Pink = Color("Pink")

    static let PinkWhite = Color("PinkWhite")
    static let Blue = Color("Blue")
    static let BlueAlpha = Color(UIColor(red: 0.345, green: 0.396, blue: 0.965, alpha: 0.6))

    static let DarkBlue = Color("DarkBlue")
    static let LightBlue = Color("LightBlue")
    static let LightGray = Color(UIColor.systemGray6)
    static let LightGray2 = Color(red: 0.9, green: 0.9, blue: 0.9)
    
    
}
