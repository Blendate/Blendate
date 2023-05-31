//
//  Vices.swift
//  Blendate
//
//  Created by Michael on 5/31/23.
//

import Foundation

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
