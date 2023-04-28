//
//  DetailCells.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/13/23.
//

import SwiftUI
import Sliders

struct DetailCell: View {
    @EnvironmentObject var entitlements: EntitlementManager

    let detail: SignupPath
    
    @Binding var user: User
    
    let isFilter: Bool
    
    @State private var showMembership = false
    
    var value: String { user.valueLabel(for: detail, isFilter) }
    var label: String { detail.label }
    var hasMembership: Bool { entitlements.hasPro }
    var disabled: Bool { detail.isPremium(isFilter) && !hasMembership}


    
    var body: some View {
        Group {
            switch detail {
            case .ageRange:
                AgeRange(label: detail.label, ageRange: $user.filters.ageRange, isChildren: false)
            case .maxDistance:
                MaxDistance(label: detail.label, distance: $user.filters.maxDistance)
            case .childrenRange:
                if isFilter {
                    AgeRange(label: detail.label, ageRange: $user.filters.childrenRange, isChildren: true, disabled: isFilter && !hasMembership)
                        .disabled(isFilter && !hasMembership)
                        .onTapGesture {
                            if !hasMembership { showMembership = true }
                        }
                } else {
                    NavigationLink {
                        PropView(path: detail, isFilter: isFilter)
                    } label: {
                        Cell(label: label, value: value, symbol: detail.systemImage, disabled: disabled)
                    }
                }

            default:
                if disabled {
                    Button(action: showPremium) {
                        Cell(label: label, value: value, symbol: detail.systemImage, disabled: disabled)
                    }
                } else {
                    NavigationLink {
                        PropView(path: detail, isFilter: isFilter)
                    } label: {
                        Cell(label: label, value: value, symbol: detail.systemImage, disabled: disabled)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $showMembership) {
            MembershipView()
        }
    }
    private func showPremium(){
        self.showMembership = true
    }

}


extension DetailCell {
    
    struct Cell: View {
        let label: String
        let value: String
        let symbol: String
        let disabled: Bool
        
        var body: some View {
            HStack {
                Image(systemName: symbol)
                    .foregroundColor(disabled ? .gray:.black )
                    .frame(width: 30)
                Text(label)
                    .foregroundColor(disabled ? .gray:.black )
                Spacer()
                Text(value)
                    .fontWeight(.semibold)
                    .foregroundColor(disabled ? .gray:.Blue )
            }
        }
    }
    
    struct AgeRange: View {
        let label: String
        var value: String {
            ageRange?.label(min:rangeIn.min, max: rangeIn.max) ?? rangeIn.label(min: rangeIn.min,max: rangeIn.max)
        }
        let systemImage: String
        @Binding var ageRange: IntRange?
        let rangeIn: IntRange
        @State var range: ClosedRange<Int>
        
        var disabled: Bool = false
        
        var color: Color {
            disabled ? .gray : .purple
        }
        
        init(label: String, ageRange: Binding<IntRange?>, isChildren: Bool, disabled: Bool) {
            self.init(label: label, ageRange: ageRange, isChildren: isChildren)
            self.disabled = disabled
        }
        
        init(label: String, ageRange: Binding<IntRange?>, isChildren: Bool) {
            self.label = label
            self._ageRange = ageRange
            self.rangeIn = isChildren ? IntRange.KKidAge : IntRange.KAgeRange
            
            let range = ageRange.wrappedValue ?? self.rangeIn
            self.range = .init(uncheckedBounds: (range.min, range.max))
            self.systemImage = isChildren ? SignupPath.childrenRange.systemImage : SignupPath.ageRange.systemImage
//            self.disabled = disabled
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 3) {
                Cell(label: label, value: value, symbol: systemImage, disabled: false)
//                HStack {
//                    Text(label)
//                    Spacer()
//                    Text(value)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.Blue)
//                }
                RangeSlider(range: $range, in: rangeIn.min...rangeIn.max, step: 1)
                    .rangeSliderStyle(
                        HorizontalRangeSliderStyle( track:
                            HorizontalRangeTrack(
                                view: Capsule().foregroundColor(color)
                            )
                            .background(Capsule().foregroundColor(color.opacity(0.25)))
                            .frame(height: 4)
                          )
                    )
            }
            .onChange(of: range) { newValue in
                if let min = newValue.min() {
                    ageRange?.min = min
                }
                if let max = newValue.max() {
                    ageRange?.max = max
                }
            }
        }
    }
    
    struct MaxDistance: View {
        let label: String

        @Binding var distance: Int
        var valueString: String { "\(distance.description) mi" }
        @State var value: Double

        init(label: String, distance: Binding<Int>) {
            self.label = label
            self._distance = distance
            self.value = Double(distance.wrappedValue)
        }
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                Cell(label: label, value: valueString, symbol: SignupPath.maxDistance.systemImage, disabled: false)
                Slider(value: $value, in: 1...50, step: 1.0)
            }
            .onChange(of: value) { newValue in
                distance = Int(newValue)
            }
        }
    }

}




struct DetailCells_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DetailCell(detail: .relationship, user: .constant(alice), isFilter: false)
            DetailCell(detail: .seeking, user: .constant(alice), isFilter: true)
            DetailCell(detail: .ageRange, user: .constant(alice), isFilter: true)
            DetailCell(detail: .maxDistance, user: .constant(alice), isFilter: true)
            DetailCell(detail: .childrenRange, user: .constant(alice), isFilter: true)
            DetailCell(detail: .childrenRange, user: .constant(alice), isFilter: false)


        }
        .listStyle(.grouped)
        .environmentObject(EntitlementManager())
    }
}
