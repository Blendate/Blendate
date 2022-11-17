//
//  Array.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import Foundation

extension Array where Element: Equatable{
    mutating func tapItem(_ element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        } else {
            append(element)
        }
    }
}
