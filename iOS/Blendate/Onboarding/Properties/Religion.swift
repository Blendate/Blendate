//
//  Religion.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import Foundation

enum Religion: String, Property, CaseIterable {
    typealias PropertyView = OptionGridView<Self>
    case orthodox, conservative, reform, traditional, other
    case none
    static let systemImage = "water.waves"
    static let svgImage = "Religion"

}

