//
//  Constants+Dummy.swift
//  Blendate
//
//  Created by Michael on 3/21/22.
//

import Foundation

extension DeveloperPreview {
//    static var michael_: Settings {
//        var usr = Settings()
//        usr.id = "123456"
//        return usr
//    }
    var filters: Stats {
        let filters = Stats(.filter)
        filters.seeking = Gender.female.value
        filters.isParent = true
        filters.children = 3
        filters.childrenRange = IntRange(1, 3)
        filters.maxDistance = 20
        filters.height = 62
        filters.relationship = Status.single.value
        filters.familyPlans = FamilyPlans.wantMore.value
        filters.mobility = Mobility.willing.value
        filters.religion = Religion.jewish.value
        filters.politics = Politics.other.value
        filters.ethnicity = Ethnicity.caucasian.value
        filters.ageRange = IntRange(20,45)
        return filters
    }
    var info: Stats {
        let info = Stats(.detail)
        info.isParent = true
        info.children = 3
        info.childrenRange = IntRange(1,5)
        info.location.name = "Brooklyn, NY"
        info.relationship = Status.single.value
        info.familyPlans = FamilyPlans.wantMore.value
        info.mobility = Mobility.willing.value
        info.religion = Religion.jewish.value
        info.politics = Politics.other.value
        info.ethnicity = Ethnicity.caucasian.value
        info.vices = [Vices.alcohol.value, Vices.smoke.value, Vices.chocolate.value, Vices.books.value]
        info.height = 60
        return filters
    }
    var michael: User {
        var details = User(id: "1234")
        details.firstname = "Michael"
        details.lastname = "Wilkowski"
        details.birthday = Date()
        details.gender = Gender.male.value
        details.bio = "kuhukltgyfg gifty bgkhy hg ghylyuh;i ghk hul hu ghb ghbul bgl bhl lk;ihs xs dre dret;ooik "
        details.workTitle = "Software Engineer"
        details.schoolTitle = "Bachelors Degree"
        details.interests = [Vices.alcohol.rawValue, Vices.smoke.rawValue, Vices.chocolate.rawValue, Vices.books.rawValue]
        details.photos = {
            var arr = [Photo]()
            arr.append(Photo(placement: 0, url: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80")))
            arr.append(Photo(placement: 1, url: URL(string: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")))
            for i in 2...7 {
                arr.append(Photo(placement: i, url: URL(string: "https://google.com")))
            }
            return arr
        }()
        
        return details
    }
    var tyler: User {
        var details = User(id: "4321")
        details.firstname = "Tyler"
        details.lastname = "Davis"
        details.birthday = Date()
        details.gender = Gender.male.value
        details.bio = "kuhukltgyfg gifty bgkhy hg ghylyuh;i ghk hul hu ghb ghbul bgl bhl lk;ihs xs dre dret;ooik "
        details.workTitle = "Hardware Engineer"
        details.schoolTitle = "Masters Degree"
        details.interests = [Vices.alcohol.rawValue, Vices.smoke.rawValue, Vices.chocolate.rawValue, Vices.books.rawValue]
        details.photos = {
            var arr = [Photo]()
            arr.append(Photo(placement: 0, url: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80")))
            arr.append(Photo(placement: 1, url: URL(string: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")))
            for i in 2...7 {
                arr.append(Photo(placement: i, url: URL(string: "https://google.com")))
            }
            return arr
        }()
        
        return details
    }


}
