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
            HStack {
                OptionButton(selected: value, property: Parent(rawValue: true))
                Spacer()
                OptionButton(selected: value, property: Parent(rawValue: false))
            }
            .padding(.horizontal, 64)

        }
    }
}
extension Parent: ExpressibleByBooleanLiteral {
    init(booleanLiteral value: Bool) {
        self.rawValue = value
    }
}


enum ParentFilter: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    static var title: String { "Parent" }

    case yes, no, none
    static let systemImage = "figure.and.child.holdinghands"
    static let svgImage = "Family"

}

struct Parent_Previews: PreviewProvider {
    @State static var parent: Parent = true
    @State static var parentFilter: ParentFilter = .no

    static var previews: some View {
        Parent.PropertyView(value: $parent)
        PropertyView(Parent.self, view: .init(value: $parent))
        PropertyView(ParentFilter.self, view: .init(value: $parentFilter))
            .previewDisplayName("Filter")
    }
}
