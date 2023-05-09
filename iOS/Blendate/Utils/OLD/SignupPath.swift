////
////  SignupPath.swift
////  Blendate
////
////  Created by Michael Wilkowski on 2/21/23.
////
//
//import SwiftUI
//
//
//enum SignupPath: String, CaseIterable, Identifiable {
//    var id: String { self.rawValue }
//    case name, birthday, gender, isParent, children, childrenRange, location, seeking, about, photos
//    
//    case relationship, familyPlans, work, education, religion, politics, mobility
//    
//    case vices, interests, height, maxDistance, ageRange
//
//    func title(_ isFilter: Bool) -> String? {
//        switch self {
//        case .name, .about, .photos: return nil
//        case .gender: return isFilter ? "Seeking" : "I identify as"
//        case .work: return "Job Title"
//        case .isParent: return isFilter ? "Are they a parent?" : "Do you have children?"
//        case .children: return isFilter ? "How many children?" : "How many children do you have?"
//        case .childrenRange: return "Children's age range"
//        case .height: return isFilter ? "Height Requirement" : "How tall are you?"
//        case .relationship: return "Relationship Staus"
//        case .familyPlans: return "Family Plans"
//        case .maxDistance: return "Max Distance"
//        case .ageRange: return "Age Range"
//        default: return self.rawValue.capitalized
//        }
//    }
//
//    var label: String {
//        switch self {
//        case .isParent: return "Parent"
//        case .childrenRange: return "Children Age Range"
//        case .familyPlans: return "Plans"
//        case .maxDistance: return "Distance"
//        case .ageRange: return "Age"
//        default: return self.rawValue.capitalized.camelCaseToWords()
//        }
//    }
//    
//    var svg: String? {
//        switch self {
//        case .name: return "Family"
//        case .birthday: return "Birthday"
//        case .gender: return "Gender"
//        case .isParent, .children, .childrenRange, .familyPlans: return "Family"
//        case .relationship: return "Relationship"
//        case .work: return "Work"
//        case .education: return "Education"
//        case .mobility: return "Mobility"
//        case .religion: return "Religion"
//        case .politics: return "Politics"
////        case .ethnicity: return "Ethnicity"
//        case .seeking: return "Interested"
//        default: return nil
//        }
//    }
//    
//    var systemImage: String {
//        switch self {
//        case .name: return "person.text.rectangle"
//        case .birthday: return "birthday.cake"
//        case .gender: return "magnifyingglass"
//        case .isParent: return "figure.and.child.holdinghands"
//        case .children: return "figure.and.child.holdinghands"
//        case .childrenRange: return "birthday.cake"
//        case .location: return "mappin"
//        case .seeking: return "magnifyingglass"
//        case .about: return "note.text"
//        case .photos: return "photo.stack"
//        case .relationship: return "figure.stand.line.dotted.figure.stand"
//        case .familyPlans: return "figure.2.and.child.holdinghands"
//        case .work: return "briefcase"
//        case .education: return "graduationcap"
//        case .religion: return "water.waves"
//        case .politics: return "building.columns"
//        case .mobility: return "box.truck"
//        case .vices: return "candybarphone"
//        case .interests: return "figure.strengthtraining.functional"
//        case .height: return "figure.stand"
//        case .maxDistance: return "map"
//        case .ageRange: return "birthday.cake"
//        }
//    }
//}
//
//extension SignupPath {
//
//    static let Required: [SignupPath] = [.name, .birthday, .gender, .isParent, .children, .childrenRange, .location, .seeking, .about, .photos]
//    static let PremiumFilters: [SignupPath] = [.childrenRange, .height, .vices, .interests]
//    static let PremiumDetails: [SignupPath] = [.vices, .interests, .height]
//    var required: Bool { Self.Required.contains(self) }
//
//    func isPremium(_ isFilter: Bool) -> Bool {
//        let premium: [SignupPath] = isFilter ? Self.PremiumFilters : Self.PremiumDetails
//        return premium.contains(self)
//    }
//
//}
//
//enum DetailGroup: String, Identifiable, CaseIterable {
//    var id: String {self.rawValue}
//    case personal, family, background, premium
//    
//    var title: String {self.rawValue.capitalized}
//    
//    func cells(isFilter: Bool, isParent: Bool) -> [SignupPath] {
//        let cells: [SignupPath]
//        switch self {
//        case .personal:
//            if isFilter {
//                cells = [.maxDistance, .ageRange, .seeking]
//            } else {
//                cells = [.location, .photos, .about, .work, .education ]
//            }
//        case .family:
//            if isParent {
//                if isFilter {
//                    cells = [.isParent, .children, .familyPlans, .mobility]
//                } else {
//                    cells = [.isParent, .children, .childrenRange, .familyPlans, .mobility]
//                }
//            } else {
//                cells = [.isParent, .familyPlans, .mobility]
//            }
//        case .background:
//            cells = [.relationship, .religion, .politics]
//        case .premium:
//            cells = isFilter ? SignupPath.PremiumFilters : SignupPath.PremiumDetails
//        }
//        return cells
//        
//    }
//    
//    var cards: [SignupPath] {
//        switch self {
//        case .personal:
//            return [.relationship, .work, .education]
//        case .family:
//            return [.isParent, .children, .childrenRange, .familyPlans]
//        case .background:
//            return [.religion, .politics]
//        case .premium:
//            return [.mobility, .vices]
//        }
//    }
//    
//    func hasValue(for user: User) -> Bool {
//        
//        for detail in cards {
//            let value = user.valueLabel(for: detail, false)
//            if !(value.isBlank) {
//                return true
//            }
//        }
//        return false
//    }
//    
//    var systemImage: String {
//        switch self {
//        case .personal:
//            return "person.fill"
//        case .family:
//            return "figure.and.child.holdinghands"
//        case .background:
//            return "house"
//        case .premium:
//            return "lock"
//        }
//    }
//}
