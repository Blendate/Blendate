//
//  FamilyPlans.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import Foundation


enum FamilyPlans: String, CaseIterable, Property {
    typealias PropertyView = OptionGridView<Self>
    case wantMore = "Want more"
    case dontWant = "Don't want more"
    case none
    static let systemImage = "figure.2.and.child.holdinghands"
    static let title = "Family Plans"
}
