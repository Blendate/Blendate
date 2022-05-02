//
//  UserDetails.swift
//  Blendate
//
//  Created by Michael on 1/9/22.
//

import SwiftUI
import CoreLocation
struct Details: Codable {

    var type: PropType = .detail
        
    var firstname: String = ""
    var lastname: String = ""
    var birthday: Date = Date()
    var gender: String = ""
    var bio: String = ""
    var workTitle: String = ""
    var schoolTitle: String = ""
    var interests: [String] = []
    
    var info: Filters = Filters(.detail)
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



enum EditDetail: String, Identifiable, CaseIterable {
    var id: String {rawValue}
    
    case photos, bio, work, education, height, relationship, isParent, children, childrenRange, familyPlans, religion, ethnicity, politics, mobility, vices, interests
    
    var label: String {
        switch self {
        case .isParent:
            return "Parent"
        case .childrenRange:
            return "Children Age Range"
        case .bio:
            return "About"
        default: return rawValue.camelCaseToWords()
        }
        
    }
    
    enum DetailGroup: String, Identifiable, Equatable, CaseIterable {
        var id: String {self.rawValue}
        case general = ""
        case personal = "Personal"
        case children = "Children"
        case background = "Background"
        case other = "Other"

        func cells(_ details: Details) -> [EditDetail] {
            switch self {
            case .general:
                return [.photos]
            case .personal:
                return [.bio, .work, .education, .height, .relationship]
            case .children:
                if details.info.isParent {
                    return [.isParent, .children, .childrenRange, .familyPlans]
                } else {
                    return [.isParent, .familyPlans]
                }
            case .background:
                return [.religion, .ethnicity, .politics]
            case .other:
                return [.mobility, .vices, .interests]
            }
        }
    }
}
struct IntRange: Codable {
    var min: Int
    var max: Int
    
    init(_ min: Int, _ max: Int){
        self.min = min
        self.max = max
    }
    
    var label: String {
        "\(min) - \(max)"
    }
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
