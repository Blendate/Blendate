//
//  CommunityService.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation

class CommunityService: FirebaseService<Conversation> {
    init(){ super.init(collection: "community") }
}
