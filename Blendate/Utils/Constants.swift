//
//  Constants.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import Foundation
import SwiftUI
import UIKit


class Dummy {
    static let userPref: UserPreferences = {
        let pref = UserPreferences()
        
        pref.firstName = "John"
        pref.lastName = "Doe"
        pref.birthday = Date()
        pref.location = "Williamsburg"
        
        return pref
    }()
    
    static let user: User = {
        let usr = User()
        usr.userPreferences = Dummy.userPref
        return usr
    }()
    
    static let matchUser: MatchUser = {
        let usr = MatchUser()
        usr.userPreferences = Dummy.userPref
        return usr
    }()
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
enum Religion: String, Codable {
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

let InterestsDict: [String:String] = [
    "Travel":"Kid Friendly Hotels, Travel Advice, Travel Accessories For Kids",
    "Child Care":"Babysitters, Childhood Education, After-School Programs",
    "Entertainment":"Movies, Music, Gaming, Podcasts, Celebrities",
    "Food":"Picky Eaters, Healthy Recipes, Veganism, Vegetarianism",
    "Entrepreneurship":"Stocks, Small Businesses, Advice, Hustlers",
    "International Affair":"Economics, Current Events, Climate, Social Issues",
    "Art":"Theater, Interior Design, Craft Art, Dance, Fashion",
    "Sports":"Baseball, Soccer, Basketball, Football, Tennis, MMA",
    "Identity":"Special Needs, Gender Identity, Puberty, Birds & Bees"
]


enum Pref: String, CaseIterable {
    case name = "Name"
    case birthday = "Age"
    case gender = "I am"
    case parent = "Parental Status"
    case numberKids = "# of Children"
    case kidsRange = "Age Range"
    case location = "Location"
    case bio = "About"
    case photos = "Photos"
    case height = "Height"
    case seeking = "I'm interested in"
    case relationship = "Relationship Staus"
    case wantKids = "Family Plans"
    case work = "Job Title"
    case education = "Education"
    case mobility = "Mobility"
    case religion = "Religion"
    case politics = "Politics"
    case ethnicity = "Ethnicity"
    case vices = "Vices"
    case interests = "Interests"
}

func getSheet(_ cell: Pref) -> AnyView {
    switch cell {
    case .name:
        return AnyView( NameView() )
    case .birthday:
        return AnyView( BirthdayView() )
    case .gender:
        return AnyView( GenderView() )
    case .parent:
        return AnyView( ParentView() )
    case .numberKids:
        return AnyView( NumberKidsView() )
    case .kidsRange:
        return AnyView( KidsRangeView() )
    case .location:
        return AnyView( LocationView() )
    case .bio:
        return AnyView( AboutView() )
    case .photos:
        return AnyView( AddPhotosView() )
    case .height:
        return AnyView( HeightView() )
    case .seeking:
        return AnyView( InterestedView() )
    case .relationship:
        return AnyView( RelationshipView() )
    case .wantKids:
        return AnyView( WantKidsView() )
    case .work:
        return AnyView( WorkView() )
    case .education:
        return AnyView( EducationView() )
    case .mobility:
        return AnyView( MobilityView() )
    case .religion:
        return AnyView( ReligionView() )
    case .politics:
        return AnyView( PoliticsView() )
    case .ethnicity:
        return AnyView( EthnicityView() )
    case .vices:
        return AnyView( VicesView() )
    case .interests:
        return AnyView( InterestsView() )
    }
}

func getValue(_ cell: Pref, _ userPreferences: UserPreferences?)->String?{
    switch cell {
    case .name:
        return userPreferences?.fullName()
    case .birthday:
        return userPreferences?.ageString()
    case .gender:
        return userPreferences?.gender
    case .parent:
        return userPreferences?.isParent ?? true ? "Has Kids":"Doesnt Have Kids"
    case .numberKids:
        return "\(userPreferences?.children ?? 0)"
    case .kidsRange:
        return "\(userPreferences?.childAgeMin ?? 0)-\(userPreferences?.childAgeMax ?? 0)"
    case .location:
        return userPreferences?.location
    case .bio:
        return userPreferences?.bio
    case .photos:
        return ""
    case .height:
        return "\(doubleToString(userPreferences?.height ?? 0.0))"
    case .seeking:
        return userPreferences?.seeking
    case .relationship:
        return userPreferences?.relationship
    case .wantKids:
        return userPreferences?.familyPlans
    case .work:
        return userPreferences?.workTitle
    case .education:
        return userPreferences?.schoolTitle
    case .mobility:
        return userPreferences?.mobility
    case .religion:
        return userPreferences?.religion
    case .politics:
        return userPreferences?.politics
    case .ethnicity:
        return userPreferences?.ethnicity
    case .vices:
        return userPreferences?.vices.first
    case .interests:
        return userPreferences?.interests.first
    }
}


let ColorGradient = LinearGradient(gradient: Gradient(colors: [Color("Pink"), Color("Blue")]), startPoint: .bottomTrailing, endPoint: .topLeading)

extension Color {
    static let Pink = Color("Pink")
    static let LightPink = Color("LightPink")
    static let DarkPink = Color("DarkPink")
    static let Blue = Color("Blue")
    static let BlueAlpha = Color(UIColor(red: 0.345, green: 0.396, blue: 0.965, alpha: 0.6))
    static let BlueGray = Color(hex: "#F0F4FE")
    static let DarkBlue = Color("DarkBlue")
    static let LightBlue = Color("LightBlue")
    static let LightGray = Color(UIColor.systemGray6)
    static let LightGray2 = Color(red: 0.9, green: 0.9, blue: 0.9)
}

extension UIColor {
    static let Pink = Color("Pink")

    static let Blue = UIColor(named: "Blue")
    static let DarkBlue = UIColor(named: "DarkBlue")
}

extension Color {
    public init?(hex: String) {
        let r, g, b: Double

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = Double((hexNumber & 0xff000000) >> 24) / 255
                    g = Double((hexNumber & 0x00ff0000) >> 16) / 255
                    b = Double((hexNumber & 0x0000ff00) >> 8) / 255

                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }
        return nil
    }
}



enum FontWeight {
    case regular
    case bold
    case semibold
    case italic
}

extension View {
    func montserrat(_ type: FontWeight = .regular, _ size: CGFloat = 14) -> some View {
        
        switch type {
        case .regular:
            return self.font(.custom("Montserrat-Regular", size: size))
        case .bold:
            return self.font(.custom("Montserrat-Bold", size: size))
        case .semibold:
            return self.font(.custom("Montserrat-SemiBold", size: size))
        case .italic:
            return self.font(.custom("Montserrat-Italic", size: size))
        }
   }
    
    func lexendDeca(_ type: FontWeight = .regular, _ size: CGFloat = 14) -> some View {
        switch type {
        case .regular:
            return self.font(.custom("LexendDeca-Regular", size: size))
        case .bold:
            return self.font(.custom("LexendDeca-Bold", size: size))
        case .semibold:
            return self.font(.custom("LexendDeca-SemiBold", size: size))
        case .italic:
            return self.font(.custom("LexendDeca-Italic", size: size))
        }
   }
    

}
