//
//  Properties.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI

protocol Property: Codable, CaseIterable, Identifiable, Hashable {
    var title: String {get}
    var label: String {get}
    var value: String {get}
    var detail: Detail {get}
    
    associatedtype V: View
    @ViewBuilder static func getDestination(_ details: Binding<UserDetails>)-> V
    
}
enum Gender: String, Property {
    
    var title: String { "I identify as"}
    var label: String {"Gender"}
    var value: String {id}
    var detail: Detail {Detail.gender}
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        GenderView(gender: details.gender)
    }


    var id: String { self.rawValue }
    case male = "Male"
    case female = "Female"
    case nonBinary = "Non-Binary"
    case none = "Open to all"
}

enum Status: String, Property {
    var title: String {"Relationship Status"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.relationship}

    var id: String { self.rawValue }

    case single = "Single"
    case divorced = "Divorced"
    case separated = "Separated"
    case widowed = "Widowed"
    case other = "Complicated"
    case none = "Open to all"
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        GenderView(gender: details.gender)
    }
}

enum FamilyPlans: String, Property {
    var title: String {"Family Plans"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.wantKids}

    var id: String { self.rawValue }
    case wantMore = "Want more"
    case dontWant = "Don't want more"
    case none = "Open to all"
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        WantKidsView(wantKids: details.familyPlans)
    }
}
enum Mobility: String, Property {
    var title: String {"Mobility"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.mobility}

    
    var id: String { self.rawValue }
    case notWilling = "Not Willing to Move"
    case willing = "Willing to Move"
    case none = "Open to all"

    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        MobilityView(mobility: details.mobility)
    }
}

enum Religion: String, Property {
    var title: String {"Religion"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.religion}

    
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
    case none = "Open to all"
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        VicesView(vices: details.vices)
    }
}

enum Politics: String, Property {
    var title: String {"Politics"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.politics}

    
    var id: String { self.rawValue }
    case conservative = "Conservative"
    case liberal = "Liberal"
    case centrist = "Centrist"
    case other = "Other"
    case none = "Open to all"
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        PoliticsView(politics: details.politics)
    }
}

enum Ethnicity: String, Property {
    var title: String {"Ethnicity"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.ethnicity}

    
    var id: String { self.rawValue }
    case caucasian = "White/Caucasian"
    case islander = "Pacific Islander"
    case african = "Black/African Descent"
    case hispanic = "Hispanic/Latinx"
    case eastAsian = "East Asian"
    case southAsian = "South Asian"
    case indian = "Native American"
    case middleEast = "Middle Eastern"
    case other = "Other"
    case none = "Open to all"
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        EthnicityView(ethnicity: details.ethnicity)
    }
}


enum Vices: String, Property {
    var title: String {"Vices"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.vices}

    
    var id: String { self.rawValue }
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
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        VicesView(vices: details.vices)
    }
}


enum Interest: String, Property {
    var title: String {"Interests"}
    var label: String {self.title}
    var value: String {id}
    var detail: Detail {Detail.interests}

    
    var id: String { self.rawValue }

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
    
    @ViewBuilder
    static func getDestination(_ details: Binding<UserDetails>) -> some View {
        GenderView(gender: details.gender)
    }
    
}
