//
//  SignupTitle.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/4/23.
//

import SwiftUI

struct SignupTitle: View {
    let detail: Detail
    let isFilter: Bool
    
    init(_ detail: Detail, _ isFilter: Bool) {
        self.detail = detail
        self.isFilter = isFilter
    }

    var body: some View {
        Text(isFilter ? filterTitle : title)
            .fontType(.semibold, 32, .DarkBlue)
            .multilineTextAlignment(.center)
            .padding(.vertical)
            .padding(.horizontal)
    }
    
    var title: String {
        switch detail {
        case .name, .bio, .photos: return " "
        case .gender: return "I identify as"
        case .work: return "Job Title"
        case .isParent: return "Do you have children?"
        case .children: return "How many children do you have?"
        case .childrenRange: return "What are your children's ages?"
        case .height: return "How tall are you?"
        case .relationship: return "Relationship Staus"
        case .familyPlans: return "Do you want more children?"
        case .maxDistance: return "Max Distance"
        case .ageRange: return "Age Range"
        default: return detail.rawValue.capitalized
        }
    }
    
    var filterTitle: String {
        switch detail {
        case .name, .bio, .photos: return " "
        case .gender: return "Seeking"
        case .work: return "Job Title"
        case .isParent: return "Are they a parent?"
        case .children: return "How many children?"
        case .childrenRange: return "Children's age ranges?"
        case .height: return "Height Requirement"
        case .relationship: return "Relationship Staus"
        case .familyPlans: return "Family Plans"
        case .maxDistance: return "Max Distance"
        case .ageRange: return "Age Range"
        default: return detail.rawValue.capitalized
        }
    }
    

}

//struct SignupTitle_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupTitle()
//    }
//}
