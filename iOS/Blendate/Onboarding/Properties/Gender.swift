//
//  Gender.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/4/23.
//

import SwiftUI

enum Gender: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    case male, female, none
    static let systemImage = "magnifyingglass"
    static let svgImage = "Gender"

}

struct Gender_Previews: PreviewProvider {
    @State static var gender: Gender = .male
    static var view: Gender.PropertyView { .init(value: $gender) }
    
    static var previews: some View {
        view
        PropertyView(Gender.self, view: view)
    }
}
