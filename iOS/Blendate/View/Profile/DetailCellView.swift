//
//  DetailCellView.swift
//  Blendate
//
//  Created by Michael on 9/30/22.
//

import SwiftUI
import Sliders


struct DetailCellView: View {
    @EnvironmentObject var premium: SettingsViewModel
    let detail: Detail
    @Binding var details: User
    let type: PropType
    @Binding var showMembership: Bool
    
    var body: some View {
        if detail == .ageRange {
            ageRangeCell
        } else if detail == .maxDistance {
            maxDistanceCell
        } else {
            detailCell
        }

    }
    
    @ViewBuilder var detailCell: some View {
        
        if detail.isPremium && !premium.hasPremium && type == .filter {
            Button {
                showMembership = true
            } label: {
                HStack {
                    Text(label)
                    Spacer()
                    value
                }
                .foregroundColor(.gray)
            }

        } else {
            NavigationLink {
                PropertyView(detail: detail, signup: false, isFilter: type == .filter)
            } label: {
                HStack {
                    Text(label)
                    Spacer()
                    value
                }
            }
        }
    }

    
    var maxDistanceCell: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(label)
                Spacer()
                Text("\(details.filters.maxDistance) mi")
                    .foregroundColor(.Blue)
            }
            Slider(value: maxDistance, in: 1...50, step: 1.0)
        }
    }
    
    var ageRangeCell: some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack {
                Text(label)
                Spacer()
                Text( details.filters.ageRange.label(min: KAgeRange.min, max: KAgeRange.max) )
                    .foregroundColor(.Blue)
            }
            RangeSlider(range: ageRange, in: KAgeRange.min...KAgeRange.max, step: 1)
        }
    }
    
    var value: some View {
        Text(details.valueLabel(for: detail, type))
            .foregroundColor(.Blue)
//            .fontType(.regular, 16, .Blue)
    }
    
    var label: String {
        switch detail {
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
        default: return detail.rawValue.camelCaseToWords()
        }
    }
}

extension DetailCellView {
    var ageRange: Binding<ClosedRange<Int>> {
        .init {
            details.filters.ageRange.min...details.filters.ageRange.max
        } set: { newValue in
            if let min = newValue.min(), min < details.filters.ageRange.max {
                details.filters.ageRange.min = min
            }
            if let max = newValue.max() {
                details.filters.ageRange.max = max
            }
        }
    }
    
    var maxDistance: Binding<Double> { .init {
        Double(details.filters.maxDistance) }
        set: { details.filters.maxDistance = Int($0) }
    }
}

struct DetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                DetailCellView(detail: .maxDistance, details: .constant(dev.michael), type: .filter, showMembership: .constant(false))
                DetailCellView(detail: .ageRange, details: .constant(dev.michael), type: .filter, showMembership: .constant(false))
                DetailCellView(detail: .gender, details: .constant(dev.michael), type: .detail, showMembership: .constant(false))
                DetailCellView(detail: .seeking, details: .constant(dev.michael), type: .filter, showMembership: .constant(false))
            }
        }
    }
}


extension User {
    func valueLabel(for detail: Detail, _ type: PropType) -> String {
        let valueType: Stats = type == .filter ? filters : info
        
        switch detail {
        case .photos:
            return String(photos.filter{!$0.isEmpty}.count)
        case .bio:
            return String(bio.prefix(25)) + "..."
        case .work:
            return workTitle
        case .education:
            return schoolTitle
        case .height:
            return valueType.height.cmToInches
        case .relationship:
            return valueType.relationship
        case .isParent:
            return valueType.isParent ? "Yes":"No"
        case .children:
            let value = valueType.children
            return String(value)
        case .childrenRange:
            return valueType.childrenRange.label(min: KKidAge.min, max: KKidAge.max)
        case .familyPlans:
            let value = valueType.familyPlans
            return value
        case .religion:
            let value = valueType.religion
            return value
        case .ethnicity:
            let value = valueType.ethnicity
            return value
        case .politics:
            let value = valueType.politics
            return value
        case .mobility:
            let value = valueType.mobility
            return value
        case .vices:
            let value = valueType.vices
            return value.stringArrayValue()
        case .interests:
            return interests.stringArrayValue()
        case .name:
            return fullName
        case .birthday:
            return ageString
        case .gender:
            return gender
        case .location:
            return info.location.name
        case .seeking:
            let value = valueType.seeking
            return value
        case .maxDistance:
            let value = valueType.maxDistance
            return value.description
        case .ageRange:
            return valueType.ageRange.label(min: KAgeRange.min, max: KAgeRange.max)
        }
    }
}

//extension User {
//    func value(for detail: Detail, isFilter: Bool) -> Any? {
//        let valueType: Stats = isFilter ? filters : info
//
//        switch detail {
//        case .name: return value(for: "firstname")
//        case .birthday, .gender, .bio, .photos, .interests: return value(for: detail.rawValue)
//        default: return valueType.value(for: detail.rawValue)
//        }
//
//    }
//
//    func setValue(_ value: Any?, for detail: Detail, isFilter: Bool) {
//        let valueType: Stats = isFilter ? filters : info
//
//        switch detail {
//        case .name:
//            if let value = value as? (String, String) {
//                firstname = value.0
//                lastname = value.1
//            }
//        case .birthday:
//            if let value = value as? Date {
//                birthday = value
//            }
//        case .gender:
//            if let value = value as? String {
//                gender = value
//            }
//        case .isParent:
//            if let value = value as? Bool {
//                valueType.isParent = value
//            }
//        case .children:
//            if let value = value as? Int {
//                valueType.children = value
//            }
//        case .childrenRange:
//            if let value = value as? IntRange {
//                valueType.childrenRange = value
//            }
//        case .location:
//            if let value = value
//        case .seeking:
//            <#code#>
//        case .bio:
//            <#code#>
//        case .photos:
//            <#code#>
//        case .relationship:
//            <#code#>
//        case .familyPlans:
//            <#code#>
//        case .work:
//            <#code#>
//        case .education:
//            <#code#>
//        case .religion:
//            <#code#>
//        case .politics:
//            <#code#>
//        case .ethnicity:
//            <#code#>
//        case .mobility:
//            <#code#>
//        case .height:
//            <#code#>
//        case .vices:
//            <#code#>
//        case .interests:
//            <#code#>
//        case .maxDistance:
//            <#code#>
//        case .ageRange:
//            <#code#>
//        }
//
//    }
//}
//extension Encodable {
//    func hasKey(for path: String) -> Bool {
//        return dictionary?[path] != nil
//    }
//    func value(for path: String) -> Any? {
//        return dictionary?[path]
//    }
//    var dictionary: [String: Any]? {
//        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any]
//    }
//}
