//
//  Constants+Dummy.swift
//  Blendate
//
//  Created by Michael on 3/21/22.
//

import Foundation

extension DeveloperPreview {
    
    static var empty = User()
    static var michael: User {
       var usr = User()
        usr.id = "123456"
        usr.settings.providers = [Provider(type: .email, email: "mikebw7@gmail.com")]
        usr.details.firstname = "Michael"
        usr.details.lastname = "Wilkowski"
        usr.details.birthday = Date()
        usr.details.gender = Gender.male.value
        usr.details.info.isParent = true
        usr.details.info.children = 3
        usr.details.info.childrenRange = IntRange(1,3)
        usr.details.info.location.name = "Brooklyn, NY"
        usr.details.bio = "kuhukltgyfg gifty bgkhy hg ghylyuh;i ghk hul hu ghb ghbul bgl bhl lk;ihs xs dre dret;ooik "
        usr.details.info.relationship = Status.single.value
        usr.details.info.familyPlans = FamilyPlans.wantMore.value
        usr.details.workTitle = "Software Engineer"
        usr.details.schoolTitle = "Bachelors Degree"
        usr.details.info.mobility = Mobility.willing.value
        usr.details.info.religion = Religion.jewish.value
        usr.details.info.politics = Politics.other.value
        usr.details.info.ethnicity = Ethnicity.caucasian.value
        usr.details.info.vices = [Vices.alcohol.value, Vices.smoke.value, Vices.chocolate.value, Vices.books.value]
        usr.details.interests = [Vices.alcohol.rawValue, Vices.smoke.rawValue, Vices.chocolate.rawValue, Vices.books.rawValue]
        usr.details.photos = {
            var arr = [Photo]()
            arr.append(Photo(url: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"), placement: 0))
            arr.append(Photo(url: URL(string: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80"), placement: 1))
            for i in 2...7 {
                arr.append(Photo(url: URL(string: "https://google.com"), placement: i))
            }
            return arr
        }()
        
        usr.filters.seeking = Gender.female.value
        usr.filters.isParent = true
        usr.filters.children = 3
        usr.filters.childrenRange = IntRange(1, 3)
        usr.filters.maxDistance = 20
        usr.filters.height = 62
        usr.filters.relationship = Status.single.value
        usr.filters.familyPlans = FamilyPlans.wantMore.value
        usr.filters.mobility = Mobility.willing.value
        usr.filters.religion = Religion.jewish.value
        usr.filters.politics = Politics.other.value
        usr.filters.ethnicity = Ethnicity.caucasian.value
        usr.filters.ageRange = IntRange(20,45)

        
        return usr
    }

    static var tyler: User {
       var usr = User()
        usr.id = "78900"
        usr.details.firstname = "Tyler"
        usr.details.lastname = "Davis"
        usr.details.bio = "kuhukltgyfg gifty bgkhy hg ghylyuh;i ghk hul hu ghb ghbul bgl bhl lk;ihs xs dre dret;ooik "
        usr.details.birthday = Date()
        usr.details.gender = Gender.male.value
        usr.details.info.isParent = true
        usr.details.info.children = 3
        usr.details.info.childrenRange = IntRange(1,5)
        usr.details.info.location.name = "Brooklyn, NY"
        usr.details.info.relationship = Status.single.value
        usr.details.info.familyPlans = FamilyPlans.wantMore.value
        usr.details.info.mobility = Mobility.willing.value
        usr.details.info.religion = Religion.jewish.value
        usr.details.info.politics = Politics.other.value
        usr.details.info.ethnicity = Ethnicity.caucasian.value
        usr.details.info.vices = [Vices.alcohol.value, Vices.smoke.value, Vices.chocolate.value, Vices.books.value]
        usr.details.info.height = 60
        return usr
    }


    static var convo: Conversation {
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
