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
    
    var body: some View {
        Button {
            selected = property
        } label: {
            ButtonView(property: property.valueLabel, active: selected == property)
        }

    }
        
    struct ButtonView: View {
        let property: String
        let active: Bool
        
        var title: String {
            property == "none" ? String.kOpenString : property
        }
        
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
}
extension OptionButton {

    
    struct Multi: View {
        @Binding var selection: [String]?
        var label: String
        var active: Bool { selection?.contains(label) ?? false }

        var body: some View {
            Button(action: {
                selection?.tapItem(label)
            }) {
                ButtonView(property: label, active: active)
            }
        }
    }
}

//
//struct DetailGridView_Previews: PreviewProvider {
//    @State static var value: String = ""
//    static var previews: some View {
//        OptionGridView<Gender>(chosen: .constant("Male"), isFilter: true)
//    }
//}
//
