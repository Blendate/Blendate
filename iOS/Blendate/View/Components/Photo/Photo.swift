//
//  Photo.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI
import CoreLocation

struct Photo: Codable {

    var placement: Int
    var url: URL?
    var isEmpty: Bool {url == nil}
    
}

extension Photo: Identifiable, Equatable {
    var id: Int {self.placement}
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.placement == rhs.placement
    }
}

extension Photo {
    static let empty: [Photo] = {
        var array: [Photo] = []
        for i in 0..<8 {
            array.append(Photo(placement: i))
        }
        return array
    }()
    
}





