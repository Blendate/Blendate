//
//  AnyProp.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI

enum Detail: String, Identifiable, CaseIterable {
    var id: String {self.title}
    
    case name, birthday, gender, isParent, children, childrenRange, location,seeking, bio, photos
    
    case relationship, familyPlans, work, education, religion, politics, ethnicity, mobility, height, vices, interests
    
    case maxDistance, ageRange
    
    var required: Bool {
        switch self {
        case .height, .relationship, .familyPlans, .work, .education, .mobility, .religion, .politics, .ethnicity, .vices:
            return false
        default:
            return true

        }
    }
    
    func label(_ type: PropType) -> String {
        switch self {
        case .isParent:
            return "Parent"
        case .childrenRange:
            return "Children Age Range"
        case .bio:
            return "About"
        case .familyPlans:
            return "Family Plans"
        case .maxDistance:
            return "Max Distance"
        case .ageRange:
            return "Age Range"
        case .height:
            return type == .filter ? "Minimum Height":"Height"
        default: return rawValue.camelCaseToWords()
        }
    }

}

// MARK: - Groups
extension Detail {
    
    enum FilterGroup: String, Identifiable, Equatable, CaseIterable {
        var id: String {self.rawValue}
        case general = "General"
        case personal = "Personal"
        case children = "Children"
        case background = "Background"
        case other = "Other"

        func cells(isParent: Bool) -> [Detail] {
            switch self {
            case .general:
                return [.maxDistance, .ageRange, .seeking]
            case .children:
                if isParent {
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
    
    enum DetailGroup: String, Identifiable, Equatable, CaseIterable {
        var id: String {self.rawValue}
        case general = "General"
        case personal = "Personal"
        case children = "Children"
        case background = "Background"
        case other = "Other"

        func cells(isParent: Bool) -> [Detail] {
            switch self {
            case .general:
                return [.location, .photos]
            case .personal:
                return [.bio, .work, .education, .height, .relationship]
            case .children:
                if isParent {
                    return [.isParent, .children, .childrenRange, .familyPlans]
                } else {
                    return [.isParent, .familyPlans]
                }
            case .background:
                return [.religion, .ethnicity, .politics]
            case .other:
                return [.mobility, .vices, .interests]
            }
        }
    }
    
}

extension Detail {
        
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
