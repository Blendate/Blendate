//
//  Parent.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/4/23.
//

import SwiftUI

struct Parent: Property, RawRepresentable {
    var rawValue: Bool
    
    var valueLabel: String { rawValue ? "Yes":"No" }
    var isValid: Bool { true }
    static let systemImage = "figure.and.child.holdinghands"
    static let svgImage = "Family"

    struct PropertyView: PropertyViewProtocol {
        var value: Binding<Parent>
        var isFilter: Bool = false
        
        var body: some View {
            VStack {
                HStack(spacing: 20) {
                    OptionButton(selected: value, property: Parent(rawValue: true))
                    OptionButton(selected: value, property: Parent(rawValue: false))
                }
//                if isFilter {
//                    OptionButton(selected: value, property: Parent(rawValue: false))
//                }
            }

        }
    }
}
extension Parent: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        self.rawValue = value
    }
}

struct Parent_Previews: PreviewProvider {
    @State static var parent: Parent = true
    
    static var previews: some View {
        Parent.PropertyView(value: $parent)
        PropertyView(Parent.self, view: .init(value: $parent))
        PropertyView(Parent.self, view: .init(value: $parent, isFilter: true))
            .previewDisplayName("Filter")
    }
}
