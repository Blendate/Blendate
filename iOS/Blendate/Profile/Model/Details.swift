//
//  UserDetails.swift
//  Blendate
//
//  Created by Michael on 1/9/22.
//

import SwiftUI
import CoreLocation
struct Details: Codable {
        
    var firstname: String = ""
    var lastname: String = ""
    var birthday: Date = Date()
    var gender: String = ""
    var bio: String = ""
    var workTitle: String = ""
    var schoolTitle: String = ""
    var interests: [String] = []
    
    var info: Stats = Stats(.detail)
    
    var photos: [Photo] = {
        var array: [Photo] = []
        for i in 0..<8 {
            array.append(Photo(placement: i))
        }
        return array
    }()
    
    var color: Color = .Blue

}

extension Details {
    var fullName: String {
        lastname.isBlank ? firstname : firstname +  " \(lastname)"
    }
    var age: Int {
        return Calendar.current.dateComponents([.year], from: birthday, to: Date()).year!
    }
}




struct IntRange: Codable {
    var min: Int
    var max: Int
    
    
    init(_ min: Int, _ max: Int){
        self.min = min
        self.max = max
    }
    
    func label(max maxValue: Int) -> String {
        let maxLabel = max > (maxValue - 1) ? "\(max - 1)+" : String(max)
        return "\(min) - \(maxLabel)"
    }
}


struct Location: Codable, Identifiable, Equatable {
    var id:String = UUID().uuidString
    var name: String
    let lat: Double
    let lon: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

}
