//
//  Contants.swift
//  Blendate
//
//  Created by Michael on 11/21/22.
//

import Foundation

// MARK: - Welcome
extension WelcomeView {
    static let ByTapping = "By tapping Create Accout/Sign in, you agree to our"
    static let ProccessData = "See how we proccess your data in our"
    static let Create = "Create Account"
    static let Signin = "Sign In"
}

// MARK: - Signup
//extension Name.PropertyView {
//    static let Lastname = "Last names help build authenticity and will only be shared with matches."
//
//}

// MARK: - Membership
extension MembershipView {
    static let TapSubscribe = "By tapping Subscribe, your payment will be charged to your Apple App Store account, and your subscription will automatically renew for the same package length at the same price until you cancel in settings in the Apple App Store. By tapping Subscribe you agree to our Terms"
}

extension PurchaseLikesView {
    static let Attention = "Get their attention with a Super Like"
    static let SuperLike = "Super Likes put you at the top of their list and gives you a better chance at matching"
}


extension String {
    static let NoProfileFilters = "There are no more profiles with your current filters, change some filters to see more profiles"
    static let EmptyLikes = "When someone likes you they will show up here, keep Bleding and check back"
    static let EmptyMatches = "Start matching with profiles to blend with others and start conversations"
    static let EmptyMessages = "Tap on any of your matches to start a conversation"
}

extension User {
    static var Alice: User {
        let ny = Location(name: "New York", lat: 40.7128, lon: -74.0060)
        let photos: [Int:Photo] = {
            var dict: [Int:Photo] = [:]
            dict[0] = Photo(placement: 0, url: URL(string: "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80")!)
            dict[1] = Photo(placement: 1, url: URL(string: "https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80")!)
            for i in 2...7 {
                dict[i] = Photo(placement: i, url: URL(string: "https://google.com")!)
            }
            return dict
        }()
        
        var filters = Filters(seeking: .male)
        filters.isParent = true
        filters.maxChildrenn = 5
        filters.childrenRange = .init(min: 1, max: 8)
        filters.minHeight = 56
        filters.relationship = .none
        filters.familyPlans = .wantMore
        filters.politics = .liberal
        
        var user = User(
            id: "999",
            firstname: "Alice",
            lastname: "Lovelace",
            birthday: Calendar.current.date(byAdding: .year, value: -10, to: Date.youngestBirthday)!,
            gender: .female,
            isParent: true,
            children: 2,
            childrenRange: .init(min: 1, max: 3),
            bio: "I like to go to to the beach with my kids on the weekends when we don't have an event like little league scheduled",
            location: ny,
            photos: photos,
            filters: .init(seeking: .male)
        )
        user.workTitle = "Teacher"
        user.schoolTitle = "Bachelor in Education"
        user.vices = [Vices.snacker.rawValue, Vices.chocolate.rawValue, Vices.coffee.rawValue]
        user.height = 52
        user.relationship = .separated
        user.familyPlans = .wantMore
        user.mobility = .willing
        user.religion = .conservative
        user.politics = .liberal
        return user
    }}
