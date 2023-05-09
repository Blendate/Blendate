//
//  AnyProp.swift
//  Blendate
//
//  Created by Michael on 4/27/22.
//

import SwiftUI



//protocol Property {
//    associatedtype T
//    associatedtype V: View
//    static func value(for user: Binding<User>, isFilter: Bool) -> Binding<T>
//    static func View(for user: Binding<User>, isFilter: Bool) -> V
//    static var options: [String] { get }
//}
//
//extension Property {
//
//    static func Vieww(for user: Binding<User>, isFilter: Bool) -> some View {
//        Self.View(for: user, isFilter: isFilter)
//    }
//}
//
//
//extension Property where Self : RawRepresentable & CaseIterable {
//    static var options: [String] {
//        Self.allCases.compactMap { option in
//            if let optionString = option.rawValue as? String {
//                if optionString == "open" {
//                    return String.kOpenString
//                } else {
//                    return optionString.capitalized
//                }
//            } else {return nil}
//        }
//    }
//
//    static func View(for user: Binding<User>, isFilter: Bool) -> OptionGridView<Self> where T == String? {
//        OptionGridView<Self>(chosen: value(for: user, isFilter: isFilter),
//                       isFilter: isFilter)
//    }
//
////    static func value(for user: Binding<User>, isFilter: Bool) -> Binding<T> {
////        let stats = isFilter ? user.filters : user.info
////        return value(for: stats)
////    }
//}
//
//
//enum Gender: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.gender
//    }
//    case male, female
//}
//
//enum Parent: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.parent
//    }
//    case yes = "Yes"
//    case no = "No"
//    case open
//}
//
//enum Seeking: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.seeking
//    }
//    case male, female
//    case open
//}
//
//
//enum RelationshipStatus: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.relationship
//    }
//    case single = "Single"
//    case divorced = "Divorced"
//    case separated = "Separated"
//    case widowed = "Widowed"
//    case other = "Complicated"
//    case open
//
//}
//
//enum FamilyPlans: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.familyPlans
//    }
//    case wantMore = "Want more"
//    case dontWant = "Don't want more"
//    case open
//}
//
//enum Politics: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.politics
//    }
//    case conservative = "Conservative"
//    case liberal = "Liberal"
//    case centrist = "Centrist"
//    case other = "Other"
//    case open
//}
//
//enum Mobility: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.mobility
//    }
//    case notWilling = "Not Willing to Move"
//    case willing = "Willing to Move"
//    case open
//}
//
////enum Vices:String, Property {
////    case alcohol = "Alcohol"
////    case snacker = "Night snacker"
////    case weed = "Marijuana"
////    case smoke = "Tobacco"
////    case psychs = "Psycedelics"
////    case sleep = "Sleeping In"
////    case nail = "Nail Biter"
////    case coffee = "Coffee"
////    case procras = "Procrastinator"
////    case chocolate = "Chocolate"
////    case tanning = "Sun Tanning"
////    case gambling = "Gambling"
////    case shopping = "Shopping"
////    case excersize = "Excercising"
////    case books = "Book Worm"
////    case open
////}
//
//
////enum Ethnicity: String, CaseIterable, Property {
////    static func value(for stats: Binding<Stats>) -> Binding<String?> {
////        stats.ethnicity
////    }
////    case caucasian = "White/Caucasian"
////    case islander = "Pacific Islander"
////    case african = "Black/African Descent"
////    case hispanic = "Hispanic/Latinx"
////    case eastAsian = "East Asian"
////    case southAsian = "South Asian"
////    case indian = "Native American"
////    case middleEast = "Middle Eastern"
////    case other = "Other"
////    case open
////}
//
//enum Religion: String, CaseIterable, Property {
//    static func value(for stats: Binding<Stats>) -> Binding<String?> {
//        stats.religion
//    }
//    case orthodox = "Orthodox"
//    case conservative = "Conservative"
//    case reform = "Reform"
//    case traditional = "Traditional"
//    case other = "Other"
//    case open
////    case atheist = "Atheist/Agnostic"
////    case christian = "Christian"
////    case catholic = "Catholic"
////    case muslim = "Muslim"
////    case jewish = "Jewish"
////    case hindu = "Hindu"
////    case buddhist = "Buddhist"
////    case islam = "Islam"
////    case sikhism = "Sikhism"
////    case other = "Other"
////    case open
//}
//
//
