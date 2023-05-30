//
//  Details.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/16/23.
//

import SwiftUI

struct Photo: Codable {
    var placement: Int
    var url: URL
    var data: Data?
    var description: String? = nil
}

extension Photo: Identifiable, Equatable, Hashable {
    var id: Int {self.placement}
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.url == rhs.url
    }
}

extension Array where Element == Photo {
    func photo(at position: Int)->Photo? {
        return first(where: {$0.placement == position})
    }
}

