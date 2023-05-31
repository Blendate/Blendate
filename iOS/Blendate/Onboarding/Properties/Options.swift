//
//  Relationship.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI

enum Relationship: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    case single, divorced, separated, widowed, seperated, other
    case none
    static let systemImage = "figure.stand.line.dotted.figure.stand"
    static let svgImage = "Relationship"
}


enum Politics: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    case conservative, liberal, centrist, other
    case none
    static let systemImage = "building.columns"
    static let svgImage = "Politics"
}


enum Mobility: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    case notWilling = "Not Willing"
    case willing = "Willing"
    case none
    static let systemImage = "box.truck"
    static let svgImage = "Mobility"
}


enum Religion: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    case orthodox, conservative, reform, traditional, other
    case none
    static let systemImage = "water.waves"
    static let svgImage = "Religion"
}


enum FamilyPlans: String, CaseIterable, Property {
    typealias PropertyView = OptionGridView<Self>
    case wantMore = "Want more"
    case dontWant = "Don't want more"
    case none
    static let systemImage = "figure.2.and.child.holdinghands"
    static let title = "Family Plans"
}
