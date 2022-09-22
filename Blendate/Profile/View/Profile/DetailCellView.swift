//
//  DetailCellView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI
import Sliders

struct DetailCellView: View {
    let detail: EditDetail
    @Binding var details: Details
    
    let sliders: [EditDetail] = [.height, .childrenRange, .bio]

    
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
        case .height: return Text(details.info.height < 52 ? "--" : details.info.height.cmToInches)
        case .childrenRange: return Text(details.info.childrenRange.label(max: KKidAge.max) )
        default: return Text("")
        }
    }
}

extension DetailCellView {
    
    @ViewBuilder
    var value: some View {
        if #available(iOS 16.0, *) {
            switch detail {
            case .childrenRange:
                RangeSlider(range: childrenRange, in: KKidAge.min...KKidAge.max, step: 1)
            case .height:
                Slider(value: height, in: 52...84, step: 1.0)
            case .isParent:
                Toggle("", isOn: $details.info.isParent).tint(.Blue)
            case .children:
                TextField("1", text: children)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .fixedSize()
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
                TextField("About Me", text: $details.bio, axis: .vertical)
                
                //            TextEditor(text: $details.bio)
                    .multilineTextAlignment(.leading)
                //                .frame(height: 80)
                    .font(.caption)
                //                .background(Color(uiColor: .systemBackground))
                    .shadow(radius: 1)
            case .work:
                TextField("Accountant at Company", text: $details.workTitle)
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .fixedSize()
            case .education:
                TextField("Masters at University", text: $details.schoolTitle)
                    .multilineTextAlignment(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .fixedSize()
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
        } else {
            // Fallback on earlier versions
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
    
    var ageRange: Binding<ClosedRange<Int>> {
        .init {
            details.info.ageRange.min...details.info.ageRange.max
        } set: { newValue in
            if let min = newValue.min() {
                details.info.ageRange.min = min
            }
            if let max = newValue.max() {
                details.info.ageRange.max = max
            }
        }
    }
    
    var childrenRange: Binding<ClosedRange<Int>> {
        .init {
            details.info.childrenRange.min...details.info.childrenRange.max
        } set: { newValue in
            if let min = newValue.min(), min < details.info.childrenRange.max {
                details.info.childrenRange.min = min
            }
            if let max = newValue.max() {
                details.info.childrenRange.max = max
            }
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
        
        DetailCellView(detail: .mobility, details: dev.$bindingMichael.details)
            .previewLayout(.sizeThatFits)
        
        DetailCellView(detail: .education, details: dev.$bindingMichael.details)
            .previewLayout(.sizeThatFits)
    }
}

