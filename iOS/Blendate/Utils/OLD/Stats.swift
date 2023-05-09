////
////  Filters.swift
////  Blendate
////
////  Created by Michael on 4/27/22.
////
//
//import Foundation
//import CoreLocation
//
//class Stats: Codable {
//    var gender: String?
//    var parent: String?
//    var children: Int?
//    var childrenRange: IntRange?
//    var height: Int?
//    var seeking: String?
//    var relationship: String?
//    var familyPlans: String?
//    var mobility: String?
//    var religion: String?
//    var politics: String?
//    var ethnicity: String?
//    var test:String?
//    var ageRange: IntRange? = IntRange(18,75)
//    var maxDistance: Int = 50
//
//    
//    init(filter: Bool = false){
//        if filter {
//            seeking = String.kOpenString
//            relationship = String.kOpenString
//            familyPlans = String.kOpenString
//            mobility = String.kOpenString
//            religion = String.kOpenString
//            politics = String.kOpenString
//            ethnicity = String.kOpenString
//            childrenRange = IntRange(0,22)
//        }
//    }
//    var isParent: Bool {
//        if let parent {
//            return parent == Parent.yes.rawValue
//        } else {
//            return false
//        }
//    }
//}
//extension Stats: Equatable {
//    static func == (lhs: Stats, rhs: Stats) -> Bool {
//        lhs.gender != rhs.gender
//    }
//    
//    
//}
//
//
//
