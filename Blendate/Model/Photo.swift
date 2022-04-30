//
//  Photo.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI
import CoreLocation

struct Photo: Codable, Equatable, Identifiable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.placement == rhs.placement
    }
    var id: Int {self.placement}
    var url: URL? = nil
    var placement: Int
    
    var isEmpty: Bool {
        return url == nil
    }
}





