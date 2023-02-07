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
        User.Settings.Premium.Access.contains(self)
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
}

