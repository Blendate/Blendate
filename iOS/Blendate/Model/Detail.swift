//
//  AnyProp.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI

enum Detail: String, Identifiable, CaseIterable {
    var id: String {self.rawValue}
    
    case name, birthday, gender, isParent, children, childrenRange, location, seeking, bio, photos
    
    case relationship, familyPlans, work, education, religion, politics, ethnicity, mobility, height, vices, interests
    
    case maxDistance, ageRange
    
    var required: Bool {
        return Stats.Required.contains(self)
//        case .height, .relationship, .familyPlans, .work, .education, .mobility, .religion, .politics, .ethnicity, .vices:
    }
    
    var isPremium: Bool {
        Premium.Access.contains(self)
    }
    
    
    func next(isParent: Bool = true) -> Detail {
        if self == .isParent, !isParent {
            return .location
        }
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }

//    var options: [String] {
//        switch self {
//        case .gender:
//            return Gender.allCases.map({$0.value})
//        case .isParent:
//            return Yes.allCases.map({$0.value})
//        case .seeking:
//            return Gender.allCases.map({$0.value})
//        case .relationship:
//            return Relationship.allCases.map({$0.value})
//        case .familyPlans:
//            return FamilyPlans.allCases.map({$0.value})
//        case .religion:
//            return Religion.allCases.map({$0.value})
//        case .politics:
//            return Politics.allCases.map({$0.value})
//        case .ethnicity:
//            return Ethnicity.allCases.map({$0.value})
//        case .mobility:
//            return Mobility.allCases.map({$0.value})
//        case .vices:
//            return Vices.allCases.map({$0.value})
//        case .interests:
//            return Interest.allCases.map({$0.value})
//        default: return []
//        }
//    }
    
//    func value(of detail: Detail, for user: Binding<User>, isFilter: Bool = false) -> Binding<String> {
//        let valueType: Binding<Stats> = isFilter ? user.filters : user.info
//
//
//    }
}

