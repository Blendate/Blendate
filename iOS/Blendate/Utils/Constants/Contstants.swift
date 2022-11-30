//
//  Contants.swift
//  Blendate
//
//  Created by Michael on 11/21/22.
//

import Foundation

// MARK: - Messages
extension MessagesView {
    static let Title = "Blends"
    static let Messages = "Messages"
    static let EmptyMatches = "Match with profiles to Blend with others"
    static let NoConversations = "Tap on any of your matches to start a conversation"
    static let NoMatches = "Start matching with profiles to blend with others and start conversations"
}

// MARK: - Welcome
extension WelcomeView {
    static let ByTapping = "By tapping Create Accout/Sign in, you agree to our"
    static let ProccessData = "See how we proccess your data in our"
    static let Create = "Create Account"
    static let Signin = "Sign In"
}

// MARK: - Signup
extension NameView {
    static let Lastname = "Last names help build authenticity and will only be shared with matches."

}

// MARK: - Membership
extension MembershipView {
    static let TapSubscribe = "By tapping Subscribe, your payment will be charged to your Apple App Store account, and your subscription will automatically renew for the same package length at the same price until you cancel in settings in the Apple App Store. By tapping Subscribe you agree to our Terms"
    static let Yearly_ID = "com.blendate.blendate.yearly"
    static let Monthly_ID = "com.blendate.blendate.monthly"
    static let SemiAnnual_ID = "com.blendate.blendate.semiAnnual"
}

// MARK: - Signup Titles
extension Detail {
    var title: String {
        switch self {
        case .name: return " "
        case .birthday: return "Birthday"
        case .gender: return "I identify as"
        case .bio: return " "
        case .photos: return " "
        case .work: return "Job Title"
        case .education: return "Education"
        case .interests: return "Interests"
        case .isParent: return "Do you have children?"
        case .children: return "How many children do you have?"
        case .childrenRange: return "What are your children's ages?"
        case .height: return "How tall are you?"
        case .relationship: return "Relationship Staus"
        case .familyPlans: return "Do you want more children?"
        case .mobility: return "Mobility"
        case .religion: return "Religion"
        case .politics: return "Politics"
        case .ethnicity: return "Ethnicity"
        case .vices: return "Vices"
        case .location: return "Location"
        case .seeking: return "Seeking"
        case .maxDistance: return "Max Distance"
        case .ageRange: return "Age Range"
        }
    }
    
    var filterTitle: String {
        switch self {
        case .name: return " "
        case .birthday: return "Birthday"
        case .gender: return "Seeking"
        case .bio: return " "
        case .photos: return " "
        case .work: return "Job Title"
        case .education: return "Education"
        case .interests: return "Interests"
        case .isParent: return "Are they a parent?"
        case .children: return "How many children?"
        case .childrenRange: return "Children's age ranges?"
        case .height: return "Height Requirement"
        case .relationship: return "Relationship Staus"
        case .familyPlans: return "Family Plans"
        case .mobility: return "Mobility"
        case .religion: return "Religion"
        case .politics: return "Politics"
        case .ethnicity: return "Ethnicity"
        case .vices: return "Vices"
        case .location: return "Location"
        case .seeking: return "Seeking"
        case .maxDistance: return "Max Distance"
        case .ageRange: return "Age Range"
        }
    }
}
