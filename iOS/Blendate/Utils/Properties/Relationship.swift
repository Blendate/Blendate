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

enum Vices: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    static let systemImage = "candybarphone"

    case alcohol = "Alcohol"
    case snacker = "Night snacker"
    case weed = "Marijuana"
    case smoke = "Tobacco"
    case psychs = "Psycedelics"
    case sleep = "Sleeping In"
    case nail = "Nail Biter"
    case coffee = "Coffee"
    case procras = "Procrastinator"
    case chocolate = "Chocolate"
    case tanning = "Sun Tanning"
    case gambling = "Gambling"
    case shopping = "Shopping"
    case excersize = "Excercising"
    case books = "Book Worm"
}
