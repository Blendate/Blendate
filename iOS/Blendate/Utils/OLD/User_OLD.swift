//
//  UserDetails.swift
//  Blendate
//
//  Created by Michael on 1/9/22.
//

import SwiftUI
import FirebaseFirestoreSwift
import CoreLocation


//class User: Codable {
//    @DocumentID var id: String?
//
//    var details: Details = Details()
//    var info: Stats = Stats(filter: false)
//    var filters = Stats(filter: true)
//
//}

//extension User: FirestoreObject {
//    static let collection = CollectionPath.Users
//}

//extension User {
//
//    func valueLabel(for detail: SignupPath, _ isFilter: Bool) -> String {
//
//        let valueType: Stats = isFilter ? filters : info
//
//        let value: String?
//
////        var label: String {
////            switch self {
////            case let string as String: return string
////            case let int as Int: return int.description
////            case let range as IntRange: return range.label(min: 0, max: 100)
////            case let array as [String]: return array.stringArrayValue()
////            case let bool as Bool: return bool ? "Yes":"No"
////            default: return "LABEL"
////            }
////        }
//
//
//        switch detail {
//        case .photos:
//            value = details.photos.count.description
//        case .about:
//            value = String(details.bio.prefix(25)) + "..."
//        case .work:
//            value = details.workTitle
//        case .education:
//            value = details.schoolTitle
//        case .height:
//            value = valueType.height?.cmToInches
//        case .relationship:
//            value = valueType.relationship
//        case .isParent:
//            let parent = valueType.parent
//            value = isFilter ? parent : (parent ?? Parent.no.rawValue)
//        case .children:
//            if let children = valueType.children {
//                value = children == 13 ? "12+" : children.description
//            } else {
//                value = nil
//            }
//        case .childrenRange:
//            value = valueType.childrenRange?.label(min: IntRange.KKidAge.min ,max: IntRange.KKidAge.max)
//        case .familyPlans:
//            value = valueType.familyPlans
//        case .religion:
//            value = valueType.religion
////        case .ethnicity:
////            value = valueType.ethnicity
//        case .politics:
//            value = valueType.politics
//        case .mobility:
//            value = valueType.mobility
//        case .vices:
//            value = details.vices?.stringArrayValue()
//        case .interests:
//            value = details.interests?.stringArrayValue()
//        case .name:
//            value = details.firstname
//        case .birthday:
//            value = details.birthday.age.description
//        case .gender:
//            value = info.gender
//        case .location:
//            value = details.location.name
//        case .seeking:
//            value = valueType.seeking
//        case .maxDistance:
//            value = valueType.maxDistance.description
//        case .ageRange:
//            value = valueType.ageRange?.label(min: IntRange.KAgeRange.min ,max: IntRange.KAgeRange.max)
//        }
//        return value ?? (isFilter ? String.kOpenString : "")
//    }
//
//    func valid(detail: SignupPath) -> Bool {
//        switch detail {
//        case .name: return (details.firstname.count > 2) && !details.firstname.isBlank
//        case .birthday:  return details.birthday.age >= 18
//        case .isParent: return info.parent != nil
//        case .children: return (info.children ?? 0) > 0
//        case .childrenRange: return info.childrenRange != nil
//        case .about: return !details.bio.isBlank
//        case .photos: return details.photos.count > 2 && details.avatar != nil && details.cover != nil
//        case .interests: return !details.interests.isEmpty
//        case .height: return info.height != 0
//        case .vices: return !details.vices.isEmpty
//        case .gender, .location, .relationship, .familyPlans, .work, .education, .mobility, .religion, .politics://, .ethnicity:
//            return !valueLabel(for: detail, false).isBlank
//        case .seeking:
//            return !valueLabel(for: .seeking, true).isBlank
//        case .maxDistance, .ageRange:
//            return !valueLabel(for: detail, true).isBlank
//        }
//    }
//}
