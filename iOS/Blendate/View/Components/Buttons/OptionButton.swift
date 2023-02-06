//
//  ItemButton.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import SwiftUI

struct OptionButton<S:Selection>: View {
    
    @Binding var value: S
    let property: String
    
    var body: some View {
        if let value = $value as? Binding<[String]> {
            Multi(selection: value, property: property)
        } else if let value = $value as? Binding<String> {
            Single(selected: value, property: property)
        }
    }
    

    
    struct ButtonView: View {
        let property: String
        let active: Bool
        
        var body: some View {
            Text(property)
                .fontType(.regular, 18, active ? .white:.Blue)
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
        @Binding var selected: String
        var property: String
        var active: Bool{ property == selected }
        
        var body: some View {
            Button {
                selected = property
            } label: {
                ButtonView(property: property, active: active)
            }
        }
    }
    
    
    struct Multi: View {
        @Binding var selection: [String]
        var property: String
        var active: Bool { selection.contains(property) }

        var body: some View {
            Button(action: {
                selection.tapItem(property)
            }) {
                ButtonView(property: property, active: active)
            }
        }
    }
}
