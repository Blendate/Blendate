//
//  Int.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import Foundation

extension Int {
    var cmToInches: String {
        let feet = Measurement(value: Double(self), unit: UnitLength.inches).converted(to: .feet)
        return feet.heightOnFeetsAndInches ?? ""
    }
}
