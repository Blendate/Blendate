//
//  UserDetails.swift
//  Blendate
//
//  Created by Michael on 1/9/22.
//

import SwiftUI
import FirebaseFirestoreSwift
import CoreLocation

class User: NSObject, Codable, Identifiable {
    @DocumentID var id: String?
    var firstname: String = ""
    var lastname: String = ""
    var birthday: Date = Date()
    var gender: String = ""
    // isParent
    var bio: String = ""
    var photos: [Photo] = Photo.empty

    var workTitle: String = ""
    var schoolTitle: String = ""
    var interests: [String] = []
    
    var info: Stats = Stats(.detail)
    var filters = Stats(.filter)

    var color: Color = .Blue
    
    init(id: String){
        self.id = id
    }
}

extension User {
    var fullName: String {
        lastname.isBlank ? firstname : firstname +  " \(lastname)"
    }
    
    var avatar: URL? {
        photos.first(where: {$0.placement == 0})?.url
    }
    
    var cover: URL? {
        photos.first(where: {$0.placement == 1})?.url
    }
    
    var ageString: String {
        return String(birthday.age)
    }
}

extension User {
    struct Settings: Codable, Identifiable  {
        @DocumentID var id: String?
        var notifications = Notifications(fcm: "", isOn: false)
        var superLikes: Int = 0
        var premium: Premium = Premium()
        
        struct Notifications: Codable {
            var fcm: String
            var isOn: Bool
            var messages: Bool = true
            var matches: Bool = true
            var likes: Bool = false
        }
        
        struct Premium: Codable {
            var invisbleBlending: Bool = false
            var hideAge: Bool = false
            var color: Color = .Blue
        }

    }

}


extension User.Settings.Premium {
    
    static let Access: [Detail] = [.childrenRange, .height, .politics, .mobility, .vices]
}
