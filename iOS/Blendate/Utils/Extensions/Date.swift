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
}
