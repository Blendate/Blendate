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
            RangeSliderView(range: $details.info.childrenRange, totalWidth: 300, slider: KKidAge)
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
            NavigationLink {
                MultiSelectPickerView(allItems: Vices.allCases.map{$0.rawValue}, selectedItems: $details.info.vices)
            } label: {
                HStack {
                    Spacer()
                    Text(stringArrayValue(details.info.vices))
                }
            }
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
            NavigationLink {
                MultiSelectPickerView(allItems: Interest.allCases.map{$0.rawValue}, selectedItems: $details.interests)
            } label: {
                HStack {
                    Spacer()
                    Text(stringArrayValue(details.interests))
                }
            }.buttonStyle(.plain)

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
    
//    struct ArrayPicker<T:Property>: View {
//        let prop: T.Type
//        @Binding var array: [String]
//
//        init(_ prop: T.Type, _ value: Binding<[String]>){
//            self.prop = prop
//            self._array = value
//        }
//        var body: some View {
//            Menu {
//                Picker("", selection: $array) {
//                    ForEach(Array(T.allCases), id: \.self.value) {
//                        Text($0.value + (array.contains($0.value) ? "+":""))
//                            .tag($0.value)
//                    }
//                    Text("--").tag("--")
//                }
//    //            .pickerStyle(.menu)
//                .labelsHidden()
//                .pickerStyle(InlinePickerStyle())
//
//            } label: {
//                Text(stringArrayValue(array))
//                    .foregroundColor(.primary)
//                // make your custom button here
//            }
//
//        }
//}

        
        struct MultiSelectPickerView: View {
            // The list of items we want to show
            @State var allItems: [String]
         
            // Binding to the selected items we want to track
            @Binding var selectedItems: [String]
         
            var body: some View {
                Form {
                    List {
                        ForEach(allItems, id: \.self) { item in
                            Button(action: {
                                withAnimation {
                                    if self.selectedItems.contains(item) {
                                        // Previous comment: you may need to adapt this piece
                                        self.selectedItems.removeAll(where: { $0 == item })
                                    } else {
                                        self.selectedItems.append(item)
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: "checkmark")
                                        .opacity(self.selectedItems.contains(item) ? 1.0 : 0.0)
                                    Text(item)
                                }
                            }
                            .foregroundColor(.primary)
                        }
                    }
                }
            }
        }
        
        func stringArrayValue(_ array: [String]) -> String {
            guard !array.isEmpty else {return "--"}
            if array.count >= 2 {
                let first = array.map({$0}).prefix(upTo: 2).joined(separator:", ")
                let moreAmount = array.count - 2
                
                let more = moreAmount < 1 ? "":" +\(moreAmount) more"
                
                return first + more
            } else {
                return array.first ?? "T"
            }
        }

}

struct DetailCellView_Previews: PreviewProvider {

    static var previews: some View {
        DetailCellView(detail: .relationship, details: dev.$bindingMichael.details)
            .previewLayout(.sizeThatFits)
    }
}

