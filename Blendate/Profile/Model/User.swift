//
//  User.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct User: Codable {
    @DocumentID var id: String?
    var details = Details()
    var filters = Stats(.filter)
    var settings = UserSettings()
    
    var fcm: String = ""
}

extension User: Identifiable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return rhs.id == lhs.id
    }
}

extension User {
    func valueLabel(for detail: Detail, _ type: PropType) -> String {
        var isFilter: Bool = type == .filter
        switch detail {
        case .photos:
            return String(details.photos.count)
        case .bio:
            return String(details.bio.prefix(25)) + "..."
        case .work:
            return details.workTitle
        case .education:
            return details.schoolTitle
        case .height:
            let value = isFilter ? filters.height : details.info.height
            return value.cmToInches
        case .relationship:
            let value = isFilter ? filters.relationship : details.info.relationship
            return value
        case .isParent:
            let value = isFilter ? filters.isParent : details.info.isParent
            return value ? "Yes":"No"
        case .children:
            let value = isFilter ? filters.children : details.info.children
            return String(value)
        case .childrenRange:
            let value = isFilter ? filters.childrenRange : details.info.childrenRange
            return "\(value.min) - \(value.max)"
        case .familyPlans:
            let value = isFilter ? filters.familyPlans : details.info.familyPlans
            return value
        case .religion:
            let value = isFilter ? filters.religion : details.info.religion
            return value
        case .ethnicity:
            let value = isFilter ? filters.ethnicity : details.info.ethnicity
            return value
        case .politics:
            let value = isFilter ? filters.politics : details.info.politics
            return value
        case .mobility:
            let value = isFilter ? filters.mobility : details.info.mobility
            return value
        case .vices:
            let value = isFilter ? filters.vices : details.info.vices
            return value.stringArrayValue()
        case .interests:
            return details.interests.stringArrayValue()
        case .name:
            return details.fullName
        case .birthday:
            return details.birthday.description
        case .gender:
            return details.gender
        case .location:
            return details.info.location.name
        case .seeking:
            let value = isFilter ? filters.seeking : details.info.seeking
            return value
        case .maxDistance:
            let value = isFilter ? filters.maxDistance : details.info.maxDistance
            return value.description
        case .ageRange:
            let value = isFilter ? filters.ageRange : details.info.ageRange
            return value.label(max: 70)
        }
    }
}
