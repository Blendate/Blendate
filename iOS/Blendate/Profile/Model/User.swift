//
//  FirbaseUser.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable {
    @DocumentID var id: String?
    
    var firstname: String
    var lastname: String
    var birthday: Date
    var gender: Gender
    var isParent: Parent
    var children: Children
    var childrenRange: KidAgeRange
    var bio: Bio
    var location: Location
    var photos: [Int:Photo]
    
    var workTitle: Work = ""
    var schoolTitle: Education = ""
    var vices: [String] = []
    var interests: [String] = []
    
    var filters: Filters
    
    // Preferences
    var height: Height = 48
    var relationship: Relationship = .none
    var familyPlans: FamilyPlans = .none
    var mobility: Mobility = .none
    var religion: Religion = .none
    var politics: Politics = .none

}

extension User {
    var avatar: URL? { photos[0]?.url }
    var cover: URL? { photos[1]?.url }
}
