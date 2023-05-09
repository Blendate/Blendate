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
        
        var body: some View {
            AgeRangeView(value: $value.rawValue, type: .age)
        }
    }
}
