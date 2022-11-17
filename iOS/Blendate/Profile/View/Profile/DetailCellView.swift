//
//  DetailCellView.swift
//  Blendate
//
//  Created by Michael on 9/30/22.
//

import SwiftUI
import Sliders


struct DetailCellView: View {
    let detail: Detail
    @Binding var user: User
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
    
    var detailCell: some View {
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
    
    var maxDistanceCell: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                label
                Spacer()
                Text("\(user.filters.maxDistance) mi")
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
                Text( user.filters.ageRange.label(max: KAgeRange.max) )
                    .fontType(.semibold, 16, .DarkBlue)
            }
            RangeSlider(range: ageRange, in: KAgeRange.min...KAgeRange.max, step: 1)
        }
    }
    
    var value: some View {
        Text(user.valueLabel(for: detail, type))
            .fontType(.semibold, 16, .DarkBlue)
    }
    
    var label: some View {
        Text(detail.label(type))
    }
}

extension DetailCellView {
    var ageRange: Binding<ClosedRange<Int>> {
        .init {
            user.filters.ageRange.min...user.filters.ageRange.max
        } set: { newValue in
            if let min = newValue.min(), min < user.filters.ageRange.max {
                user.filters.ageRange.min = min
            }
            if let max = newValue.max() {
                user.filters.ageRange.max = max
            }
        }
    }
    
    var maxDistance: Binding<Double> { .init {
        Double(user.filters.maxDistance) }
        set: { user.filters.maxDistance = Int($0) }
    }
}

struct DetailCellView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                DetailCellView(detail: .maxDistance, user: dev.$bindingMichael, type: .filter)
                DetailCellView(detail: .ageRange, user: dev.$bindingMichael, type: .filter)
                DetailCellView(detail: .gender, user: dev.$bindingMichael, type: .detail)
                DetailCellView(detail: .seeking, user: dev.$bindingMichael, type: .filter)
            }
        }

    }
}
