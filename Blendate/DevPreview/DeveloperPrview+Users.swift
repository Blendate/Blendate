//
//  Constants+Dummy.swift
//  Blendate
//
//  Created by Michael on 3/21/22.
//

import Foundation


extension DeveloperPreview {
    var michael: User {
       var usr = User(id: "12345")
        usr.settings.providers = [Provider(type: .email, email: "mikebw7@gmail.com")]
        usr.details.firstname = "Michael"
        usr.details.lastname = "Wilkowski"
        usr.details.birthday = Date()
        usr.details.gender = Gender.male.value
        usr.details.isParent = true
        usr.details.children = 3
        usr.details.childrenRange = IntRange(1,3)
        usr.details.location.name = "Brooklyn, NY"
        usr.details.bio = "kuhukltgyfg gifty bgkhy hg ghylyuh;i ghk hul hu ghb ghbul bgl bhl lk;ihs xs dre dret;ooik "
        usr.details.relationship = Status.single.value
        usr.details.familyPlans = FamilyPlans.wantMore.value
        usr.details.workTitle = "Software Engineer"
        usr.details.schoolTitle = "Bachelors Degree"
        usr.details.mobility = Mobility.willing.value
        usr.details.religion = Religion.jewish.value
        usr.details.politics = Politics.other.value
        usr.details.ethnicity = Ethnicity.caucasian.value
        usr.details.vices = [Vices.alcohol.value, Vices.smoke.value, Vices.chocolate.value, Vices.books.value]
        usr.details.interests = [Vices.alcohol.rawValue, Vices.smoke.rawValue, Vices.chocolate.rawValue, Vices.books.rawValue]
        usr.details.photos = {
            var arr = [Photo]()
            for i in 0...7 {
                arr.append(Photo(url: URL(string: "https://google.com")!, placement: i))
            }
            return arr
        }()
        
        usr.filters.gender = Gender.female
        usr.filters.isParent = true
        usr.filters.children = 3
        usr.filters.childrenRange = IntRange(1, 3)
        usr.filters.maxDistance = 20
        usr.filters.minHeight = 62
        usr.filters.relationship = Status.single.value
        usr.filters.familyPlans = FamilyPlans.wantMore.value
        usr.filters.mobility = Mobility.willing.value
        usr.filters.religion = Religion.jewish.value
        usr.filters.politics = Politics.other.value
        usr.filters.ethnicity = Ethnicity.caucasian.value

        
        return usr
    }

    var tyler: User {
       var usr = User(id: "54321")
        usr.details.firstname = "Tyler"
        usr.details.lastname = "Davis"
        usr.details.bio = "kuhukltgyfg gifty bgkhy hg ghylyuh;i ghk hul hu ghb ghbul bgl bhl lk;ihs xs dre dret;ooik "
        usr.details.birthday = Date()
        usr.details.gender = Gender.male.value
        usr.details.isParent = true
        usr.details.children = 3
        usr.details.childrenRange = IntRange(1,5)
        usr.details.location.name = "Brooklyn, NY"
        usr.details.relationship = Status.single.value
        usr.details.familyPlans = FamilyPlans.wantMore.value
        usr.details.mobility = Mobility.willing.value
        usr.details.religion = Religion.jewish.value
        usr.details.politics = Politics.other.value
        usr.details.ethnicity = Ethnicity.caucasian.value
        usr.details.vices = [Vices.alcohol.value, Vices.smoke.value, Vices.chocolate.value, Vices.books.value]
        usr.details.height = 60
        return usr
    }


    var convo: Conversation {
        var convo = Conversation(id: "FAKE ID", users: [michael.id!, tyler.id!], chats: [], timestamp: Date())
        convo.chats = [
            ChatMessage(author: michael.id!, text: "Dev Michael"),
            ChatMessage(author: tyler.id!, text: "Dev Tyler")
        ]
        
        for i in 2...10 {
            let user = i % 2 == 0 ? michael:tyler
            convo.chats.append(ChatMessage(author: user.id!, text: "\(user.details.firstname)"))
        }
        
        return convo
    }
}
