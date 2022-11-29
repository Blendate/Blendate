//
//  PremiumPerks.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import Foundation

enum PremiumPerks: String, Identifiable, CaseIterable {
    var id: String {self.rawValue}
    
    
    case matches
    case likes
    case filters
    case swipes
    
    var title: String {
        switch self {
        case .likes:
            return "See others who liked you"
        case .filters:
            return "Access to more filters"
        case .swipes:
            return "Unlimited profiles to view"
        case .matches:
            return "Match with more profiles"
        }
    }
    
    var description: String {
        switch self {
        case .likes:
            return "View the users that liked you"
        case .filters:
            return "Set advanced filters and settings"
        case .swipes:
            return "Find your blended family quicker"
        case .matches:
            return "Your profile will be seen by more users"
        }
    }
    
}
