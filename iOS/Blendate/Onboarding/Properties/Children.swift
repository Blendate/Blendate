//
//  Children.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/9/23.
//

import SwiftUI

struct Children: Property, RawRepresentable, ExpressibleByIntegerLiteral {
    var rawValue: Int

    init(integerLiteral value: Int) {
        self.rawValue = value
    }
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
    var valueLabel: String { rawValue.description }
    
    var isValid: Bool { rawValue >= 0 }
    
    static let systemImage = "face.smiling"
    
    struct PropertyView: PropertyViewProtocol {
        @Binding var value: Children
        var isFilter: Bool = false
        
        var active: Bool {
            value == .init(rawValue: -1)
        }
        
        var body: some View {
            VStack {
                AgeRangeView(value: $value.rawValue, type: .age)
                    .padding(.top, 64)
                if isFilter {
                    Button{
                        if active {
                            self.value = .init(rawValue: 0)
                        } else {
                            self.value = .init(rawValue: -1)
                        }
                    } label: {
                        ButtonView(title: "Open to all", active: active)
                    }
                }
            }

        }
    }
}

struct Children_Previews: PreviewProvider {
    @State static var children: Children = 8
    static var view: Children.PropertyView { .init(value: $children) }
    
    static var previews: some View {
        view
        PropertyView(Children.self, view: view)
            .previewDisplayName("Property")
    }
}
