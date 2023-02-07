//
//  Properties.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI


enum Gender: String, Options {
    var id: String {rawValue}

    case male = "Male"
    case female = "Female"
    case nonBinary = "Non-Binary"

}

enum Relationship: String, Options {
    var id: String {rawValue}
    
    case single = "Single"
    case divorced = "Divorced"
    case separated = "Separated"
    case widowed = "Widowed"
    case other = "Complicated"

}

enum FamilyPlans: String, Options {
    var id: String { rawValue }
    case wantMore = "Want more"
    case dontWant = "Don't want more"
    case dontCare = "Dont care"

}
enum Mobility: String, Options {
    var id: String { self.rawValue }
    case notWilling = "Not Willing to Move"
    case willing = "Willing to Move"
    case dontCare = "Don't Care"
}

enum Religion: String, Options {
    var id: String { self.rawValue }
    case atheist = "Atheist/Agnostic"
    case christian = "Christian"
    case catholic = "Catholic"
    case muslim = "Muslim"
    case jewish = "Jewish"
    case hindu = "Hindu"
    case buddhist = "Buddhist"
    case islam = "Islam"
    case sikhism = "Sikhism"
    case other = "Other"
}

enum Politics: String, Options {
    var id: String { self.rawValue }
    case conservative = "Conservative"
    case liberal = "Liberal"
    case centrist = "Centrist"
    case other = "Other"
}

enum Ethnicity: String, Options {
    var id: String { rawValue }
    case caucasian = "White/Caucasian"
    case islander = "Pacific Islander"
    case african = "Black/African Descent"
    case hispanic = "Hispanic/Latinx"
    case eastAsian = "East Asian"
    case southAsian = "South Asian"
    case indian = "Native American"
    case middleEast = "Middle Eastern"
    case other = "Other"
}


enum Vices: String, Options {
    var id: String { rawValue }
    
    case alcohol = "Alcohol"
    case snacker = "Night snacker"
    case weed = "Marijuana"
    case smoke = "Tobacco"
    case psychs = "Psycedelics"
    case sleep = "Sleeping In"
    case nail = "Nail Biter"
    case coffee = "Coffee"
    case procras = "Procrastinator"
    case chocolate = "Chocolate"
    case tanning = "Sun Tanning"
    case gambling = "Gambling"
    case shopping = "Shopping"
    case excersize = "Excercising"
    case books = "Book Worm"
}


enum Interest: String, Options {
    var id: String { rawValue }
    
    var title: String {id}
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

enum Yes: String, Options {
    var value: String {id}
    
    var id: String { self.rawValue }
    case yes = "Yes"
    case no = "No"
    
    var boolValue: Bool {
        switch self {
        case .yes:
            return true
        case .no:
            return false
        }
    }
}
