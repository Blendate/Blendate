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

extension CaseIterable where Self: Equatable {
    func next() -> Self {
        let all = Self.allCases
        let idx = all.firstIndex(of: self)!
        let next = all.index(after: idx)
        return all[next == all.endIndex ? all.startIndex : next]
    }
}
