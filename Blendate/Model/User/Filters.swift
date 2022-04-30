//
//  Filters.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import Foundation

enum PropType:Codable { case detail, filter }

let kOpenString:String = "Open to all"


struct Filters: Codable {    
    var isParent: Bool = false
    var children: Int = 0
    var childrenRange = IntRange(0, 1)
    var height: Int = 0
    var seeking: String = "--"
    var relationship: String = "--"
    var familyPlans: String = "--"
    var mobility: String = "--"
    var religion: String = "--"
    var politics: String = "--"
    var ethnicity: String = "--"
    var vices: [String] = []

    var ageRange = IntRange(18, 75)
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
//        case maxDistance, ageRange, seeking, isParent, children, childrenRange, height, relationship, familyPlans,
//            mobility, religion, politics, ethnicity, vices
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

//
//
//extension Filters {
//
//    mutating func set(_ property: Detail, _ value: Any) {
//        let bool = value as? Bool ?? false
//        let string = value as? String ?? "Open to all"
//        let stringArray = value as? [String] ?? []
//        let int = value as? Int ?? 0
//        let range = value as? IntRange ?? IntRange(0, 1)
//        let location = value as? Location ?? Location(name: "New York", lat: 40.7128, lon: -74.0060)
//
//        switch property {
//
//
//        case .seeking: seeking = string
//        case .isParent: isParent = bool
//        case .children: children = int
//        case .childrenRange: childrenRange = range
//        case .height: height = int
//        case .relationship: relationship = string
//        case .familyPlans: familyPlans = string
//        case .mobility: mobility = string
//        case .religion: religion = string
//        case .politics: politics = string
//        case .ethnicity: ethnicity = string
//        case .vices: vices = stringArray
//        case .ageRange: ageRange = range
//        case .maxDistance: maxDistance = int
//        case .location: self.location = location
//        default: return
//        }
//    }
//
//    func getValue(_ detail: Detail) -> Any {
//        switch detail {
//        case .seeking: return seeking
//        case .relationship: return relationship
//        case .familyPlans: return familyPlans
//        case .mobility: return mobility
//        case .religion: return religion
//        case .politics: return politics
//        case .ethnicity: return ethnicity
//        case .isParent: return isParent
//        case .children: return children
//        case .childrenRange: return childrenRange
//        case .height: return height
//        case .vices: return vices
//        case .ageRange: return ageRange
//        case .maxDistance: return maxDistance
//        case .location: return location
//        default: return "NONE"
//        }
//    }


//}
