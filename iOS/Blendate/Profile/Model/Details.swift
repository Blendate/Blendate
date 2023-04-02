//
//  Details.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/16/23.
//

import SwiftUI
import CoreLocation

extension User {
struct Details: Codable {
    var firstname: String = ""
    var lastname: String = ""
    var birthday: Date = Date()
    var bio: String = ""
    var photos: [Int:Photo] = [:]
    var location: Location = Location(name: "", lat: 0, lon: 0)

    var workTitle: String = ""
    var schoolTitle: String = ""
    var vices: [String]? = []
    var interests: [String]? = []
}
}

struct Location: Codable, Identifiable, Equatable {
    var id:String { "\(lat),\(lon)"}
    var name: String
    let lat: Double
    let lon: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}


struct IntRange: Codable {
    var min, max: Int
    
    init(_ min: Int, _ max: Int) { self.min = min; self.max = max }
    
    func maxLabel(max: Int) -> String {
        if self.max >= max {
            return "\(max - 1)+"
        } else {
            return String(self.max)
        }
    }
    func minLabel(min: Int) -> String {
        if self.min <= 0 {
            return "<1"
        } else {
            return String(self.min)
        }
    }
    
    func label(min: Int, max: Int) -> String {
        return "\(minLabel(min: min)) - \(maxLabel(max: max))"
    }
    
//    func label(min minRange: Int, max maxRange: Int) -> String {
//
//        let minLabel = min < (minRange + 1) ? "\(min)" : String(min)
//        let maxLabel = max > (maxRange - 1) ? "\(max - 1)+" : String(max)
//
//        let minYears = min < 2 ? "yr" : "yrs"
//        let maxYears = max < 2 ? "yr" : "yrs"
//
//        if min == max {
//            return minLabel + minYears
//        } else {
//            return "\(minLabel)\(minYears) - \(maxLabel)\(maxYears)"
//        }
//    }
}


extension IntRange {

    static let KAgeMin: Int = 18
    static let KAgeMax: Int = 76
    static let KKidMin: Int = 1
    static let KKidMax: Int = 22

    static let KAgeRange: IntRange = IntRange(KAgeMin,KAgeMax)
    static let KKidAge: IntRange = IntRange(KKidMin,KKidMax)
}


extension User.Details {
    var avatar: URL? { photos[0]?.url }
    var cover: URL? { photos[1]?.url }
}

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

