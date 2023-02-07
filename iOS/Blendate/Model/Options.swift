//
//  Options.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/6/23.
//

import Foundation

protocol Options: Codable, CaseIterable, Identifiable, Hashable {
    var id: String {get}
}
extension Options {
    var value: String {id}
}

protocol Selection {}
extension Array: Selection where Element == String {}
extension String: Selection {}
