//
//  Premium.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/16/23.
//

import SwiftUI

extension User.Settings {
    struct Premium: Codable {
        var invisbleBlending: Bool = false
        var hideAge: Bool = false
        var color: Color = .Blue
        var superLikes: Int = 0
//        var membership: Bool = false

    }
}

extension User.Settings.Premium {
    struct Error: ErrorAlert {
        var title = "Premium"
        var message = "This feature is for premium members only."
        
        static let NoSuperLikes = Error(title: "Super Like", message: "You are out of Super Likes")
    }
}
