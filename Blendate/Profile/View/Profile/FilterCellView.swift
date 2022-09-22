//
//  FilterCellView.swift
//  Blendate
//
//  Created by Michael on 4/28/22.
//

import SwiftUI
import Sliders

struct FilterCellView: View {
    let filter: Filter
    @Binding var filters: Filters
    let width: CGFloat
    
    let sliders: [Filter] = [.height, .childrenRange, .maxDistance, .ageRange]
    
    var body: some View {
        if sliders.contains(filter) {
            VStack {
                HStack {
                    filterLabel
                    Spacer()
                    sliderLabel
                }
                value
            }
        } else {
            HStack {
                filterLabel
                Spacer()
                value
            }
        }
    }
    
    var filterLabel: some View {
        Text(filter.label)
            .fontType(.semibold, 16, .DarkBlue)
            .padding(.vertical, 15)
    }
    
    var sliderLabel: some View {
        switch filter {
        case .height: return Text(filters.height < 52 ? "--" : filters.height.cmToInches)
        case .childrenRange: return Text(filters.childrenRange.label(max:KKidAge.max) )
        case .maxDistance: return Text("\(filters.maxDistance) mi")
        case .ageRange: return Text( filters.ageRange.label(max: KAgeRange.max) )
        default: return Text("")
        }
    }
    
    @ViewBuilder
    var value: some View {
        switch filter {
        case .childrenRange:
            RangeSlider(range: childrenRange, in: KKidAge.min...KKidAge.max, step: 1)
        case .height:
            Slider(value: height, in: 52...84, step: 1.0)
        case .isParent:
            FilterPicker(Yes.self, isParent)
        case .children:
            FilterPicker(Yes.self, children)
        case .seeking:
            FilterPicker(Gender.self, $filters.seeking)
        case .relationship:
            FilterPicker( Status.self, $filters.relationship)
        case .familyPlans:
            FilterPicker( FamilyPlans.self, $filters.familyPlans)
        case .mobility:
            FilterPicker( Mobility.self, $filters.mobility)
        case .religion:
            FilterPicker( Religion.self, $filters.religion)
        case .politics:
            FilterPicker( Politics.self, $filters.politics)
        case .ethnicity:
            FilterPicker( Ethnicity.self, $filters.ethnicity)
        case .vices:
            FilterPicker( Ethnicity.self, $filters.ethnicity)
        case .maxDistance:
            Slider(value: maxDistance, in: 1...50, step: 1.0)
        case .ageRange:
            RangeSlider(range: ageRange, in: KAgeRange.min...KAgeRange.max, step: 1)
        }
    }
    
    var isParent: Binding<String> {
        .init {
            filters.isParent ? "Yes":"No"
        } set: { newValue in
            filters.isParent = newValue == "Yes" ? true:false
        }
    }
    
    var children: Binding<String> { .init {
        filters.children > 0 ? "Yes":"No" }
        set: { filters.children = $0 == "Yes" ? 1:0 }
    }
    
    var height: Binding<Double> { .init {
        Double(filters.height) }
        set: { filters.height = Int($0) }
    }
    
    var maxDistance: Binding<Double> { .init {
        Double(filters.maxDistance) }
        set: { filters.maxDistance = Int($0) }
    }
    
    var ageRange: Binding<ClosedRange<Int>> {
        .init {
            filters.ageRange.min...filters.ageRange.max
        } set: { newValue in
            if let min = newValue.min(), min < filters.ageRange.max {
                filters.ageRange.min = min
            }
            if let max = newValue.max() {
                filters.ageRange.max = max
            }
        }
    }
    
    var childrenRange: Binding<ClosedRange<Int>> {
        .init {
            filters.childrenRange.min...filters.childrenRange.max
        } set: { newValue in
            if let min = newValue.min(), min < filters.childrenRange.max {
                filters.childrenRange.min = min
            }
            if let max = newValue.max() {
                filters.childrenRange.max = max
            }
        }
    }
    
    func stringArrayValue(_ array: [String]) -> String {
        if !array.isEmpty {
            let first = array.map({$0}).prefix(upTo: 2).joined(separator:", ")
            let moreAmount = array.count - 2
            
            let more = moreAmount < 1 ? "":" +\(moreAmount) more"
            
            return first + more
        } else {
            return ""
        }
    }
    struct FilterPicker<T:Property>: View {
        let prop: T.Type
        @Binding var value: String
        
        init(_ prop: T.Type, _ value: Binding<String>){
            self.prop = prop
            self._value = value
        }
        var body: some View {
            Menu {
                Picker("", selection: $value) {
                    ForEach(Array(T.allCases), id: \.self.value) {
                        Text($0.value)
                            .tag($0.value)
                    }
                    Text("Open to all").tag("Open to all")
                }
    //            .pickerStyle(.menu)
                .labelsHidden()
                .pickerStyle(InlinePickerStyle())

            } label: {
                Text(value)
                    .foregroundColor(.primary)
                // make your custom button here
            }

        }
    }
}

struct FilterCellView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCellView(filter: .ethnicity, filters: dev.$bindingMichael.filters, width: 300)
            .previewLayout(.sizeThatFits)
        FilterCellView(filter: .height, filters: dev.$bindingMichael.filters, width: 300)
            .previewLayout(.sizeThatFits)

        FilterCellView(filter: .maxDistance, filters: dev.$bindingMichael.filters, width: 300)
            .previewLayout(.sizeThatFits)
        
        FilterCellView(filter: .ageRange, filters: dev.$bindingMichael.filters, width: 300)
            .previewLayout(.sizeThatFits)

    }
}
struct Cell<Content, Accessory> where Content: View, Accessory: View {
    var content: Content
    var accessory: Accessory
}

