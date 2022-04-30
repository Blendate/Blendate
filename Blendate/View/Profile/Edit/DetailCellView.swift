//
//  DetailCellView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

struct DetailCellView: View {
    let detail: EditDetail
    @Binding var details: Details
    
    let sliders: [EditDetail] = [.height, .childrenRange]

    
    var body: some View {
        if sliders.contains(detail) {
            VStack {
                HStack {
                    detailLabel
                    Spacer()
                    sliderLabel
                }
                value
            }
        } else {
            HStack {
                detailLabel
                Spacer()
                value
            }
        }
    }
    
    var detailLabel: some View {
        Text(detail.label)
            .fontType(.semibold, 16, .DarkBlue)
            .padding(.vertical, 15)
    }
    
    var sliderLabel: some View {
        switch detail {
        case .height: return Text(Int(details.info.height).cmToInches)
        case .childrenRange: return Text(details.info.childrenRange.label )
        default: return Text("")
        }
    }
}

extension DetailCellView {
    
    @ViewBuilder
    var value: some View {
        switch detail {
        case .childrenRange:
            RangeSliderView(range: $details.info.childrenRange, totalWidth: 300, slider: IntRange(1, 12))
        case .height:
            Slider(value: height, in: 1...50, step: 1.0).tint(.Blue)
        case .isParent:
            Toggle("", isOn: $details.info.isParent).tint(.Blue)
        case .children:
            TextField("", text: children)
                .multilineTextAlignment(.trailing)
                .keyboardType(.numberPad)
        case .relationship:
            PropPicker( Status.self, $details.info.relationship)
        case .familyPlans:
            PropPicker( FamilyPlans.self, $details.info.familyPlans)
        case .mobility:
            PropPicker( Mobility.self, $details.info.mobility)
        case .religion:
            PropPicker( Religion.self, $details.info.religion)
        case .politics:
            PropPicker( Politics.self, $details.info.politics)
        case .ethnicity:
            PropPicker( Ethnicity.self, $details.info.ethnicity)
        case .vices:
            PropPicker( Ethnicity.self, $details.info.ethnicity)
        case .photos:
            NavigationLink {
                AddPhotosView(photos: $details.photos, signup: false)
            } label: {EmptyView()}.tint(.Blue)
        case .bio:
            TextField("", text: $details.bio)
                .multilineTextAlignment(.trailing)
        case .work:
            TextField("", text: $details.workTitle)
                .multilineTextAlignment(.trailing)
        case .education:
            TextField("", text: $details.schoolTitle)
                .multilineTextAlignment(.trailing)
        case .interests:
            Text(stringArrayValue(details.interests))
        }
    }
    
    var isParent: Binding<String> {
        .init {
            details.info.isParent ? "Yes":"No"
        } set: { newValue in
            details.info.isParent = newValue == "Yes" ? true:false
        }
    }
    
    var children: Binding<String> { .init {
        String(details.info.children) }
        set: { details.info.children = Int(Double($0) ?? 1)  }
    }
    
    var height: Binding<Double> { .init {
        Double(details.info.height) }
        set: { details.info.height = Int($0) }
    }
    
    var maxDistance: Binding<Double> { .init {
        Double(details.info.maxDistance) }
        set: { details.info.maxDistance = Int($0) }
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
    
    struct PropPicker<T:Property>: View {
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
                    Text("--").tag("--")
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

struct DetailCellView_Previews: PreviewProvider {

    static var previews: some View {
        DetailCellView(detail: .relationship, details: dev.$bindingMichael.details)
            .previewLayout(.sizeThatFits)
    }
}

