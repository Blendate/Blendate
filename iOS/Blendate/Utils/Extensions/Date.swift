//
//  Date.swift
//  Blendate
//
//  Created by Michael on 11/21/22.
//

import Foundation

extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: .now).year!
    }
    
    static var youngestBirthday: Date {
        let now = Date.now
        return Calendar.current.date(
            byAdding: .year,
            value: -18,
            to: now) ?? now
    }
}
