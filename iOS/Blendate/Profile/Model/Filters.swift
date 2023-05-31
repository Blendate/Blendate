//
//  Filters.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import Foundation

struct Filters: Codable {
    var seeking: Gender = .none
    var isParent: ParentFilter = .none
    var maxChildrenn: Children = 10
    var childrenRange: KidAgeRange = KidAgeRange.defaultValue
    var minHeight: Height = 48
    var relationship: Relationship = .none
    var familyPlans: FamilyPlans = .none
    var mobility: Mobility = .none
    var religion: Religion = .none
    var politics: Politics = .none
    
    var ageRange: AgeRange = .defaultValue
    var maxDistance: Int = 50
}
