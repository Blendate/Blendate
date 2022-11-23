//
//  Filters.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import Foundation

class Stats: Codable {    
    var isParent: Bool = true
    var children: Int = 0
    var childrenRange = IntRange(0,1)
    var height: Int = 60
    var seeking: String = ""
    var relationship: String = ""
    var familyPlans: String = ""
    var mobility: String = ""
    var religion: String = ""
    var politics: String = ""
    var ethnicity: String = ""
    var vices: [String] = []

    var ageRange = KAgeRange
    var maxDistance: Int = 50

    var location: Location = Location(name: "", lat: 0, lon: 0)
    
    
    init(_ type: PropType){
        if type == .filter {
            seeking = kOpenString
            relationship = kOpenString
            familyPlans = kOpenString
            mobility = kOpenString
            religion = kOpenString
            politics = kOpenString
            ethnicity = kOpenString
            childrenRange = IntRange(0,19)
        }
    }
}


struct IntRange: Codable {
    var min, max: Int
    
    init(_ min: Int, _ max: Int) { self.min = min; self.max = max }
    
    func label(max maxValue: Int) -> String {
        let maxLabel = max > (maxValue - 1) ? "\(max - 1)+" : String(max)
        return "\(min) - \(maxLabel)"
    }
}

enum PropType:Codable { case detail, filter }

let kOpenString:String = "Open to all"
let KAgeRange: IntRange = IntRange(18,76)
let KKidAge: IntRange = IntRange(0,22)
let kEmailKey: String = "kEmailKey"
