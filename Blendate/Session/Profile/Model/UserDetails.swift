//
//  UserDetails.swift
//  Blendate
//
//  Created by Michael on 1/9/22.
//

import SwiftUI

struct UserDetails: Codable {
    var firstname: String = ""
    var lastname: String = ""
    var birthday: Date = Date()
    var gender: String = ""
    
    var isParent: Bool = false
    var children: Int = 1
    var childrenRange = IntRange(0,0)
    var location: Location = Location(name: "", lat: 0, lon: 0)
    var bio: String = ""
    var height: Int?
    var relationship: String = ""
    var familyPlans: String = ""
    var workTitle: String = ""
    var schoolTitle: String = ""
    var mobility: String = ""
    var religion: String = ""
    var politics: String = ""
    var ethnicity: String = ""
    var vices: [String] = []
    var interests: [String] = []
    
    var photos: [Photo] = []
    var color: Color = .Blue

}

extension Binding where Value == String? {
    var optionalBinding: Binding<String> {
        .init(
            get: {
                self.wrappedValue ?? ""
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}
extension Binding where Value == Color? {
    var optionalBinding: Binding<Color> {
        .init(
            get: {
                self.wrappedValue ?? Color.Blue
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}

extension Binding where Value == Bool? {
    var optionalBinding: Binding<Bool> {
        .init(
            get: {
                self.wrappedValue ?? false
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}



extension UserDetails {
    func fullName()->String {
        if !lastname.isBlank {
            return (firstname) +  " \(lastname)"
        } else {
            return firstname
        }
    }

    func age()->Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        if let age = ageComponents.year {
            return age
        } else {
            return 90
        }
    }

    
    func kidsString()->String? {
        guard children > 0 else {return nil}
        return String(children)
    }
    
    func rangeString()->String {
        return "\(childrenRange.min) - \(childrenRange.max)"
    }
    
    func heightString()->String? {
        guard let height = height else {return nil}
        let feet = Measurement(value: Double(height), unit: UnitLength.inches).converted(to: .feet)
        if let feetString = feet.heightOnFeetsAndInches {
            return feetString
        } else {
            return nil
        }
    }
    
}

import UIKit

fileprivate extension Color {
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        

        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        
        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}
