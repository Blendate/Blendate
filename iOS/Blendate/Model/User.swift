//
//  UserDetails.swift
//  Blendate
//
//  Created by Michael on 1/9/22.
//

import SwiftUI
import FirebaseFirestoreSwift
import CoreLocation

class User: Codable, Identifiable {
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

    var premium: Premium = Premium()
    var color: Color = .Blue
    
    init(id: String){
        self.id = id
    }
    private enum CodingKeys: String, CodingKey {
        case id
        case firstname
        case lastname
        case birthday
        case gender
        // isParent
        case bio
        case photos

        case workTitle
        case schoolTitle
        case interests
        
        case info
        case filters

        case premium
        case color
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
        if premium.active, premium.hideAge {
            return ""
        } else {
            return String(birthday.age)
        }
    }
}

struct Premium: Codable {
    var active: Bool = false
    var invisbleBlending: Bool = false
    var hideAge: Bool = false
}
