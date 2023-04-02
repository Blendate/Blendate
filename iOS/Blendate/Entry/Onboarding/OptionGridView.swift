//
//  DetailGridView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/4/23.
//

import SwiftUI


struct OptionGridView<O:Property>: View {
    
    @Binding var chosen: String?
    var isFilter: Bool
    var selection: [String] = O.options

    var options: [String] {
        let options = selection
        return isFilter ? options : options.filter{$0 != String.kOpenString}
    }
    var collumns: Int = 2
    
    private var main: [String] { options.dropLast(options.count % collumns) }
    private var extra: [String] { options.suffix(options.count % collumns) }
    
    private var preference: [GridItem] {
        .init(repeating: .init(.flexible()), count: collumns)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: preference) {
                ForEach(main, id: \.self) { property in
                    OptionButton(value: $chosen, label: property)
                }
            }
            LazyHStack {
                ForEach(extra, id: \.self) { property in
                    OptionButton(value: $chosen, label: property)

                }
            }
        }
    }
}

struct OptionButton: View {
    
    @Binding var value: String?
    let label: String
    
    var body: some View {
        Single(selected: $value, label: label)
//        if let value = value as? Binding<[String]?> {
//            Multi(selection: value, label: label)
//        } else if let value = value as? Binding<String?> {
//            Single(selected: value, label: label)
//        }
    }
        
    struct ButtonView: View {
        let property: String
        let active: Bool
        
        var title: String {
            property == String.kOpenString ? String.kOpenString : property
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
    struct Single: View {
        @Binding var selected: String?
        var label: String
        var active: Bool{
            if label == String.kOpenString, selected == nil {
                return true
            } else {
                return label == selected
            }
        }
        
        var body: some View {
            Button {
                if active {
                    selected = nil
                } else {
                    selected = label
                }
            } label: {
                ButtonView(property: label, active: active)
            }
        }
    }
    
    
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
