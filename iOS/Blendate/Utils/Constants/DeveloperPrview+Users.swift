//
//  Constants+Dummy.swift
//  Blendate
//
//  Created by Michael on 3/21/22.
//

import SwiftUI

extension DevPreviewProvider {

    var filters: Stats {
        let filters = Stats(filter: true)
        filters.seeking = "Female"
        filters.parent = Parent.yes.rawValue
        filters.children = 3
        filters.childrenRange = IntRange(1, 3)
        filters.maxDistance = 20
        filters.height = 62
        filters.relationship = RelationshipStatus.single.rawValue
        filters.familyPlans = FamilyPlans.wantMore.rawValue
        filters.mobility = Mobility.willing.rawValue
//        filters.religion = Religion.jewish.rawValue
        filters.politics = Politics.other.rawValue
//        filters.ethnicity = Ethnicity.caucasian.rawValue
        filters.ageRange = IntRange(20,45)
//        info.interests = [Vices.alcohol.rawValue, Vices.smoke.rawValue, Vices.chocolate.rawValue, Vices.books.rawValue]
        return filters
    }
    var info: Stats {
        let info = Stats(filter: false)
        info.parent = Parent.yes.rawValue
        info.children = 3
        info.childrenRange = IntRange(1,5)
        info.relationship = RelationshipStatus.single.rawValue
        info.familyPlans = FamilyPlans.wantMore.rawValue
        info.mobility = Mobility.willing.rawValue
//        info.religion = Religion.jewish.rawValue
        info.politics = Politics.other.rawValue
//        info.ethnicity = Ethnicity.caucasian.rawValue
//        info.vices = [Vices.alcohol.value, Vices.smoke.value, Vices.chocolate.value, Vices.books.value]
//        info.interests = [Vices.alcohol.rawValue, Vices.smoke.rawValue, Vices.chocolate.rawValue, Vices.books.rawValue]

        info.height = 60
        return filters
    }
    var details: User.Details {
        var details = User.Details()
        details.firstname = "Alice"
        details.lastname = "Lovelace"
        details.birthday = Date()
        details.bio = String(String.LoremIpsum.prefix(120))
        details.workTitle = "Software Engineer"
        details.schoolTitle = "Bachelors Degree"
        details.photos = {
            var dict: [Int:Photo] = [:]
            dict[0] = Photo(placement: 0, url: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80")!)
            dict[1] = Photo(placement: 1, url: URL(string: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")!)
            for i in 2...7 {
                dict[i] = Photo(placement: i, url: URL(string: "https://google.com")!)
            }
            return dict
        }()
        
        return details
    }
    var bob_details: User.Details {
        var details = User.Details()
        details.firstname = "Bob"
        details.lastname = "Oderick"
        details.birthday = Date()
        details.bio = String(String.LoremIpsum.prefix(60))
        details.workTitle = "Hardware Engineer"
        details.schoolTitle = "Masters Degree"
        details.photos = {
            var dict: [Int:Photo] = [:]
            dict[0] = Photo(placement: 0, url: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80")!)
            dict[1] = Photo(placement: 1, url: URL(string: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")!)
            for i in 2...7 {
                dict[i] = Photo(placement: i, url: URL(string: "https://google.com")!)
            }
            return dict
        }()
        
        return details
    }


}
