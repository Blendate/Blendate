//
//  Interests.swift
//  Blendate
//
//  Created by Michael on 5/31/23.
//

import Foundation

enum Interests: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    static let systemImage = "figure.yoga"

    case travel = "Travel"
    case childCare = "ChildCare"
    case entertainment = "Entertainment"
    case food = "Food"
    case entrepreneur = "Entrepreneurship"
    case international = "International Affair"
    case art = "Art"
    case sports = "Sports"
    case identity = "Identity"
    
    var subString: String {
        subtTitles.joined(separator:", ")
    }
    
    var subtTitles: [String] {
        switch self {
        case .travel:
            return ["Kid Friendly Hotels","Travel Advice", "Travel Accessories For Kids"]
        case .childCare:
            return ["Babysitters", "Childhood Education", "After-School Programs"]
        case .entertainment:
            return ["Movies", "Music", "Gaming", "Podcasts", "Celebrities"]
        case .food:
            return ["Picky Eaters", "Healthy Recipes", "Veganism", "Vegetarianism"]
        case .entrepreneur:
            return ["Stocks", "Small Businesses", "Advice, Hustlers"]
        case .international:
            return ["Economics", "Current Events", "Climate", "Social Issues"]
        case .art:
            return ["Theater", "Interior Design", "Craft Art", "Dance", "Fashion"]
        case .sports:
            return ["Baseball", "Soccer", "Basketball", "Football", "Tennis", "MMA"]
        case .identity:
            return ["Special Needs", "Gender Identity", "Puberty", "Birds & Bees"]
        }
    }
}
