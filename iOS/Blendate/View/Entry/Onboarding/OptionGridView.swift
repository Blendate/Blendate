//
//  DetailGridView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/4/23.
//

import SwiftUI


struct OptionGridView<O:Options, S:Selection>: View {
    @Binding var value: S
    
    var collumns: Int = 2
    private let options: [String]
    
    
    init(_ value: Binding<S>, collumns: Int? = nil, isFilter:Bool = false){
        self._value = value
        let selection = O.allCases.map{$0.value}
        self.options = isFilter ? selection : selection.filter{$0 != kOpenString}
        self.collumns = collumns ?? selection.count == 3 ? 1 : 2

    }
    
    
    private var main: [String] { options.dropLast(options.count % collumns) }
    private var extra: [String] { options.suffix(options.count % collumns) }
    
    private var preference: [GridItem] {
        .init(repeating: .init(.flexible()), count: collumns)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: preference) {
                ForEach(main, id: \.self) { property in
                    OptionButton(value: $value, property: property)
                }
            }
            LazyHStack {
                ForEach(extra, id: \.self) { property in
                    OptionButton(value: $value, property: property)

                }
            }
        }
    }
}

struct DetailGridView_Previews: PreviewProvider {
    @State static var value: String = ""
    static var previews: some View {
        OptionGridView<Gender, String>(.constant("Male"))
    }
}

