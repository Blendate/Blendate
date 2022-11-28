//
//  Location.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation
import CoreLocation

struct Location: Codable, Identifiable, Equatable {
    var id:String { "\(lat),\(lon)"}
    var name: String
    let lat: Double
    let lon: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
