//
//  ItemButton.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import SwiftUI

struct ItemButton<T:Property>: View {
    
    @Binding var value: String
    var property: T

    init(_ value: Binding<String>, _ property: T){
        self._value = value
        self.property = property
    }
    
    
    var body: some View {
        let active = active()
        Button {
            value = property.value
        } label: {
            Text(property.value)
                .fontType(.regular, 18, active ? .white:.Blue)
                .padding(.horizontal)
                .padding()
                .background(active ? Color.Blue:Color.white)
                .clipShape(Capsule())
                .shadow(color: .Blue, radius: 1, x: 0, y: 1)
//                .overlay(
//                    Capsule()
//                        .stroke(Color.Blue, lineWidth: 2)
//                )
        }

    }
    
    func active()->Bool{
        if let property = property.id as? String{
            return property == value
        } else {
            return false
        }
    }
}



struct ItemArray<T:Property>: View {
    @Binding var array: [String]
    var property: T
    
    init(_ array: Binding<[String]>, _ property: T){
        self._array = array
        self.property = property
    }
    
    var body: some View {
        let active = array.contains(property.value)
        Button(action: {
            array.tapItem(property.value)
        }) {
            Text(property.value)
                .fontType(.regular, 18, active ? .white:.Blue)
                .padding(.horizontal)
                .padding()
                .background(active ? Color.Blue:Color.white)
                .clipShape(Capsule())
                .shadow(color: .Blue, radius: 1, x: 0, y: 1)
//                .overlay(
//                    Capsule()
//                        .stroke(Color.Blue, lineWidth: 2)
//                )
        }
    }
}

struct Item: View {
    let title: String
    let active: Bool
    var action: ()->Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontType(.regular, 18, active ? .white:.Blue)
                .padding(.horizontal)
                .padding()
                .background(active ? Color.Blue:Color.white)
                .clipShape(Capsule())
                .shadow(color: .Blue, radius: 1, x: 0, y: 1)

        }
    }
}

struct ItemButton_Previews: PreviewProvider {
    static var previews: some View {
        ItemButton(.constant("Female"), Gender.female)
            .padding()
            .previewLayout(.sizeThatFits)
        ItemButton(.constant("Male"), Gender.female)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
