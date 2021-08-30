//
//  RealmUser.swift
//  Blendate
//
//  Created by Michael on 7/22/21.
//

import Foundation
import RealmSwift

//func UserPartition()->String {
//    guard let id = app.currentUser?.id else { return ""}
//    return "user=\(id)"
//}

func UserConfig()->Realm.Configuration {
    guard let user = app.currentUser else {return Realm.Configuration()}
    let id = user.id
    let config = user.configuration(partitionValue: "user=\(id)")
    return config
}

func MatchUserConfig()->Realm.Configuration {
    guard let user = app.currentUser else {return Realm.Configuration()}
    let config = user.configuration(partitionValue: AllUsersPartition)
    return config
}

@objcMembers class User: Object, ObjectKeyIdentifiable {
    
    dynamic var _id = UUID().uuidString
    dynamic var partition = "" // "user=_id"
    dynamic var identifier = ""
    dynamic var userPreferences: UserPreferences?
    dynamic var seekingPreferences: UserPreferences?

    var conversations = RealmSwift.List<Conversation>()
    dynamic var presence = "Off-Line"
    
    var presenceState: Presence {
        get { return Presence(rawValue: presence) ?? .hidden }
        set { presence = newValue.asString }
    }

    override static func primaryKey() -> String? {
        return "_id"
    }
}

@objcMembers class UserPreferences: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var profilePhoto: Photo?
    dynamic var coverPhoto: Photo?

    dynamic var photo1: Photo?
    dynamic var photo2: Photo?
    dynamic var photo3: Photo?
    dynamic var photo4: Photo?
    dynamic var photo5: Photo?
    dynamic var photo6: Photo?


    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var birthday: Date = Date()
    dynamic var gender: String = ""

    dynamic var isParent: Bool = false
    dynamic var children: Int = 0
    dynamic var childAgeMin: Int = 0
    dynamic var childAgeMax: Int = 0
    dynamic var location: String = ""
    dynamic var bio: String = ""
    dynamic var height: Double = 0
    dynamic var seeking: String = ""
    dynamic var relationship: String = ""
    dynamic var familyPlans: String = ""
    dynamic var workTitle: String = ""
    dynamic var schoolTitle: String = ""
    dynamic var mobility: String = ""
    dynamic var religion: String = ""
    dynamic var politics: String = ""
    dynamic var ethnicity: String = ""
    let vices = RealmSwift.List<String>()
    let interests = RealmSwift.List<String>()
}

extension UserPreferences {

    func fullName()->String {
        return (firstName) + " " + (lastName)
    }

    func ageString()->String {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        if let age = ageComponents.year {
            return "\(age)"
        } else {
            return "--"
        }
    }

    func feet() -> String {
        let feet = height * 0.0328084
        let feetShow = Int(floor(feet))
        let feetRest: Double = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
        let inches = Int(floor(feetRest * 12))
        return "\(feetShow)' \(inches)\""
    }
}

