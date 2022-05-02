//
//  AnyProp.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI


enum Detail: Identifiable, CaseIterable {
    var id: String {self.title}
    
    case name, birthday, gender, isParent, children, childrenRange, location,seeking, bio, photos
    
    case relationship, familyPlans, work, education, religion, politics, ethnicity, mobility, height, vices, interests

    
    var title: String {
        switch self {
        case .name: return "Name"
        case .birthday: return "Age"
        case .gender: return "I am"
        case .bio: return "About"
        case .photos: return "Photos"
        case .work: return "Job Title"
        case .education: return "Education"
        case .interests: return "Interests"

        case .isParent: return "Parent"
        case .children: return "# of Children"
        case .childrenRange: return "Children Ages"
        case .height: return "Height"
        case .relationship: return "Relationship Staus"
        case .familyPlans: return "Family Plans"
        case .mobility: return "Mobility"
        case .religion: return "Religion"
        case .politics: return "Politics"
        case .ethnicity: return "Ethnicity"
        case .vices: return "Vices"
        case .location: return "Location"
        case .seeking: return "Seeking"
        }
    }
    var label: String { title }
    
    var signupTitle: String {
        switch self {
        case .name: return " "
        case .gender: return "I identify as"
        case .birthday: return "Birthday"
        case .bio: return " "
        case .isParent: return "Do you have children?"
        case .children: return "How many children do you have?"
        case .childrenRange: return "What is the age range of your children?"
        case .familyPlans: return "Do you want more children?"
        case .height: return "How tall are you?"
        case .photos: return "Add Photos"
        default: return self.title
        }
    }
    
    var required: Bool {
        switch self {
        case .height, .relationship, .familyPlans, .work, .education, .mobility, .religion, .politics, .ethnicity, .vices:
            return false
        default:
            return true

        }
    }
}


