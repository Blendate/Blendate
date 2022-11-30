//
//  DetailCellView.swift
//  Blendate
//
//  Created by Michael on 9/30/22.
//

import SwiftUI
import Sliders


struct DetailCellView: View {
    @EnvironmentObject var premium: PremiumViewModel
    let detail: Detail
    @Binding var details: User
    let type: PropType
    
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
                showMembership()
            } label: {
                HStack {
                    label
                    Spacer()
                    value
                }
                .foregroundColor(.gray)
            }

        } else {
            NavigationLink {
                PropertyView(detail, signup: false, propType: type)
            } label: {
                HStack {
                    label
                    Spacer()
                    value
                }
            }
        }
    }
    
    @MainActor
    func showMembership(){
        premium.showMembership.toggle()
    }
    
    var maxDistanceCell: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                label
                Spacer()
                Text("\(details.filters.maxDistance) mi")
                    .fontType(.semibold, 16, .DarkBlue)
            }
            Slider(value: maxDistance, in: 1...50, step: 1.0)
        }
    }
    
    var ageRangeCell: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                label
                Spacer()
                Text( details.filters.ageRange.label(max: KAgeRange.max) )
                    .fontType(.semibold, 16, .DarkBlue)
            }
            RangeSlider(range: ageRange, in: KAgeRange.min...KAgeRange.max, step: 1)
        }
    }
    
    var value: some View {
        Text(details.valueLabel(for: detail, type))
            .fontType(.semibold, 16, .DarkBlue)
    }
    
    var label: some View {
        Text(detail.label(type))
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
                DetailCellView(detail: .maxDistance, details: .constant(dev.michael), type: .filter)
                DetailCellView(detail: .ageRange, details: .constant(dev.michael), type: .filter)
                DetailCellView(detail: .gender, details: .constant(dev.michael), type: .detail)
                DetailCellView(detail: .seeking, details: .constant(dev.michael), type: .filter)
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
            let value = valueType.height
            return value.cmToInches
        case .relationship:
            let value = valueType.relationship
            return value
        case .isParent:
            let value = valueType.isParent
            return value ? "Yes":"No"
        case .children:
            let value = valueType.children
            return String(value)
        case .childrenRange:
            let value = valueType.childrenRange
            return "\(value.min) - \(value.max)"
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
            let value = valueType.ageRange
            return value.label(max: 70)
        }
    }
}
