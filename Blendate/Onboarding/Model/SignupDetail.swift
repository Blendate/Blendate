//
//  AnyProp.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI


enum SignupDetail: Identifiable, CaseIterable {
    var id: String {self.title}
    
    case name, birthday, gender, isParent, children, childrenRange, location,seeking, bio, photos
    
    case relationship, familyPlans, work, education, religion, politics, ethnicity, mobility, height, vices, interests

    
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
        }
    }
    
    var hasTitle: Bool {
        switch self {
//        case .birthday: return false
        default: return true
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
    
    var svgName: String? {
        switch self {
        case .name: return "Family"
        case .birthday: return "Birthday"
        case .gender: return "Gender"
        case .isParent, .children, .childrenRange, .familyPlans: return "Family"
        case .relationship: return "Relationship"
        case .work: return "Work"
        case .education: return "Education"
        case .mobility: return "Mobility"
        case .religion: return "Religion"
        case .politics: return "Politics"
        case .ethnicity: return "Ethnicity"
        default:
            return nil
        }
    }
}


