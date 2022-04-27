//
//  User.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift
import CoreLocation

struct User: Identifiable, Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return rhs.id == lhs.id
    }
    
    @DocumentID var id: String?
    var details = UserDetails()
    var filters = Filters()
    var settings = UserSettings()
    var fcm: String = ""
}


struct Photo: Codable, Equatable, Identifiable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.placement == rhs.placement
    }
    var id: Int {self.placement}
    var url: URL? = nil
    var placement: Int
}

struct Location: Codable, Identifiable, Equatable {
    var id:String = UUID().uuidString
    var name: String
    let lat: Double
    let lon: Double
    func coordinate()->CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
