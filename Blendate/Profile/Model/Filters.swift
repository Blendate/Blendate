//
//  Filters.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import Foundation

enum PropType:Codable { case detail, filter }

let kOpenString:String = "Open to all"
let KAgeRange: IntRange = IntRange(18,76)
let KKidAge: IntRange = IntRange(0,22)
let kEmailKey: String = "kEmailKey"

struct Filters: Codable {    
    var isParent: Bool = false
    var children: Int = 0
    var childrenRange = IntRange(0,1)
    var height: Int = 60
    var seeking: String = "--"
    var relationship: String = "--"
    var familyPlans: String = "--"
    var mobility: String = "--"
    var religion: String = "--"
    var politics: String = "--"
    var ethnicity: String = "--"
    var vices: [String] = []

    var ageRange = KAgeRange
    var maxDistance: Int = 50

    var location: Location = Location(name: "", lat: 0, lon: 0)
    
    
    init(_ type: PropType){
        if type == .filter {
            seeking = kOpenString
            relationship = kOpenString
            familyPlans = kOpenString
            mobility = kOpenString
            religion = kOpenString
            politics = kOpenString
            ethnicity = kOpenString
            childrenRange = IntRange(0,19)
        }
    }
}

enum Filter: String, Identifiable, CaseIterable {
    var id: String {rawValue}
    case maxDistance, ageRange, seeking, isParent, children, childrenRange, height, relationship, familyPlans,
        mobility, religion, politics, ethnicity, vices
    var label: String {
        switch self {
        case .isParent:
            return "Parent"
        case .childrenRange:
            return "Children Age Range"
        case .maxDistance:
            return "Max Distance"
        case .ageRange:
            return "Age Range"
        case .familyPlans:
            return "Family Plans"
        case .height:
            return "Minimum Height"
        default: return rawValue.camelCaseToWords()
        }
        
    }
    
    enum FilterGroup: String, Identifiable, Equatable, CaseIterable {
        var id: String {self.rawValue}
        case general = "General"
        case personal = "Personal"
        case children = "Children"
        case background = "Background"
        case other = "Other"

        func cells(_ filters: Filters) -> [Filter] {
            switch self {
            case .general:
                return [.maxDistance, .ageRange, .seeking]
            case .children:
                if filters.isParent {
                    return [.isParent, .children, .childrenRange, .familyPlans]
                } else {
                    return [.isParent, .familyPlans]
                }
            case .personal:
                return [.height, .relationship]
            case .background:
                return [.religion, .ethnicity, .politics]
            case .other:
                return [.mobility, .vices]
            }
        }
    }
}

