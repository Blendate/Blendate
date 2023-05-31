//
//  DetailGridView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/4/23.
//

import SwiftUI


struct OptionGridView<P:Property>: PropertyViewProtocol where P:CaseIterable, P:RawRepresentable, P.RawValue == String {
    init(value: Binding<P>, isFilter: Bool = false) {
        self._chosen = value
        self.isFilter = isFilter
    }
    
    @Binding var chosen: P
    var isFilter: Bool
    var selection: [P] = P.allCases as? [P] ?? []

    var options: [P] {
        return isFilter ? selection : selection.filter{$0.rawValue != "none"}
    }
    var collumns: Int = 2
    
    private var main: [P] { options.dropLast(options.count % collumns) }
    private var extra: [P] { options.suffix(options.count % collumns) }
    
    private var preference: [GridItem] {
        .init(repeating: .init(.flexible()), count: collumns)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: preference) {
                ForEach(main, id: \.self.rawValue) { property in
                    OptionButton(selected: $chosen, property: property)
                }
            }
            LazyHStack {
                ForEach(extra, id: \.self.rawValue) { property in
                    OptionButton(selected: $chosen, property: property)
                }
            }
        }
    }
}

struct OptionButton<P:Property>: View {

    @Binding var selected: P
    let property: P
    
    var active: Bool { selected == property }
    
    var title: String {
        property.valueLabel == "none" ? String.kOpenString : property.valueLabel
    }
    
    var body: some View {
        Button {
            selected = property
        } label: {
            ButtonView(title: title, active: active)
        }
    }
}

struct ButtonView: View {
    let title: String
    var active: Bool
    
    var body: some View {
        Text(title)
            .foregroundColor( active ? .white:.Blue)
            .padding(.horizontal)
            .padding()
            .background(active ? Color.Blue:Color.white)
            .clipShape(Capsule())
            .shadow(color: .Blue, radius: 1, x: 0, y: 1)
    }
}


struct OptionGridView_Previews: PreviewProvider {    
    @State static var gender: Gender = .male
    
    static var previews: some View {
        OptionButton(selected: $gender, property: gender)
//        OptionGridView<Gender>(chosen: .constant("Male"), isFilter: true)
    }
}
//
//extension OptionButton {
//
//
//    struct Multi: View {
//        @Binding var selection: [String]?
//        var label: String
//        var active: Bool { selection?.contains(label) ?? false }
//
//        var body: some View {
//            Button(action: {
//                selection?.tapItem(label)
//            }) {
//                ButtonView(property: label, active: active)
//            }
//        }
//    }
//}
