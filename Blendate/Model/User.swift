//
//  User.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import Foundation
import SwiftUI

struct User: Encodable, Decodable, Identifiable {
    var id = UUID()
        
    var uid: String 
    
    var identifier: String = ""
//    var completeSignup = false
    
    var match: MatchUser
    var images: [Int:String] = [:]
    var profileImage: String = ""
    var coverPhoto: String = ""
    
    var firstName: String = ""
    var lastName: String = ""
    var birthday: Date = Date()
    var gender: Gender = .none
    var isParent: Bool = true
    var children: Int = 0
    var childrenAge: IntRange = IntRange(min: 0, max: 0)
    
    var location: String = ""
    var bio: String = ""

    private var isDate: Bool = true
    
    init(id: String){
        self.uid = id
        self.match = MatchUser()
    }
    
    // DATEUSER
    
    var height: Double = 0
    var seeking: Gender?
    var relationship: Status?
    var familyPlans: FamilyPlans?
    var workTitle: String = ""
    var schoolTitle: String = ""
    var religion: Religion?
    var politics: Politics?
    var ethnicity: Ethnicity?
    var mobility: Mobility?
    var vices: [Vice] = []
    var interests: [String] = []
    
    var dislike: [String] = []
    var like: [String] = []
    
    var hometown: String?
    
    func fullName()->String {
        return firstName + " " + lastName
    }
    
    func age()->Int {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        return ageComponents.year ?? 0
    }
    
    func feet() -> String {
        let feet = height * 0.0328084
        let feetShow = Int(floor(feet))
        let feetRest: Double = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
        let inches = Int(floor(feetRest * 12))
        return "\(feetShow)' \(inches)\""
    }
}

struct MatchUser: Encodable, Decodable {
    var birthday: Date = Date()
    var gender: Gender = .none
    var isParent: Bool = true
    var children: Int = 0
    var childrenAge: IntRange = IntRange(min: 0, max: 0)
    
    var location: String = ""
    var height: Double = 0
    var seeking: Gender?
    var relationship: Status?
    var familyPlans: FamilyPlans?
    var workTitle: String = ""
    var schoolTitle: String = ""
    var religion: Religion?
    var politics: Politics?
    var ethnicity: Ethnicity?
    var mobility: Mobility?
    var vices: [Vice] = []
    var interests: [String] = []
}

struct IntRange: Codable {
    var min: Int
    var max: Int
}

enum FamilyPlans: String, Codable {
    case wantMore = "Want more children"
    case dontWant = "Don't want more children"
    case dontCare = "Open to all"
}

enum Status: String, Codable {
    case single = "Single"
    case divorced = "Divorced"
    case separated = "Separated"
    case widowed = "Widowed"
    case other = "Complicated"
}

enum Gender: String, Codable {
    case male = "Male" // Men
    case female = "Female" //Women
    case nonBinary = "Non-Binary" // non-binary
    case other = "Prefer not to say" // open to all
    case none = "null"
}

enum Ethnicity: String, Codable {
    case caucasian = "White/Caucasian"
    case islander = "Pacific Isander"
    case african = "Black/African Descent"
    case hispanic = "Hispanic/Latinx"
    case eastAsian = "East Asian"
    case southAsian = "South Asian"
    case indian = "Native American"
    case middleEast = "Middle Eastern"
    case other = "Other"

}
enum Religion: String, Codable, CaseIterable {
    case atheist = "Atheist/Agnostic"
    case christian = "Christian"
    case catholic = "Catholic"
    case muslim = "Muslim"
    case jewish = "Jewish"
    case hindu = "Hindu"
    case buddhist = "Buddhist"
    case chinese = "Chinese Traditional"
    case islam = "Islam"
    case sikhism = "Sikhism"
    case other = "Other"
}

enum Politics: String, Codable {
    case conservative = "Conservative"
    case liberal = "Liberal"
    case centrist = "Centrist"
    case other = "Other"
}

enum Mobility: String, Codable {
    case notWilling = "Not Willing to Move"
    case willing = "Willing to Move"
    case noPref = "No Preference"
}

enum Vice: String, Codable {
    case alcohol = "Alcohol"
    case snacker = "Late night snacker"
    case weed = "Marijuana"
    case smoke = "Tobacco"
    case psychs = "Psycedelics"
    case sleep = "Sleeping In"
    case nail = "Nail Biter"
    case coffee = "Coffee"
    case procras = "Procrastinator"
    case chocolate = "Chocolate"
    case tanning = "Sun Tanning"
    case gambling = "Gambling"
    case shopping = "Shopping"
    case excersize = "Excercising"
    case books = "Book Worm"


}

extension Encodable {
    func toDic() throws -> [String:Any] {
        let data = try JSONEncoder().encode(self)
        
        guard let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any] else {
            throw NSError()
        }
        return dict
    }
}

extension Decodable {
    init(fromDict: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: fromDict, options: JSONSerialization.WritingOptions.prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
}

extension Binding where Value == User? {
    func unwrapSession() -> Binding<User> {
        return Binding<User>(
            get: {
                return self.wrappedValue ?? User(id: "")
            },
            set: {
                self.wrappedValue = $0
            }
        )
    }
}
