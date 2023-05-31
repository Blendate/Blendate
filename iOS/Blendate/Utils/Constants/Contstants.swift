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
            dict[2] = Photo(placement: 2, url: URL(string: "https://images.unsplash.com/photo-1520114878144-6123749968dd?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8Y2l0eSxuaWdodHx8fHx8fDE2ODU0NzY1NTU&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080")! )
            dict[3] = Photo(placement: 3, url: URL(string: "https://images.unsplash.com/photo-1505069190533-da1c9af13346?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8Y2l0eSx0cmF2ZWx8fHx8fHwxNjg1NDc2Njg2&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080")!)
            dict[4] = Photo(placement: 4, url: URL(string: "https://images.unsplash.com/photo-1510265236892-329bfd7de7a1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8Y2l0eSx0cmF2ZWx8fHx8fHwxNjg1NDc2NzI3&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080")!)
            dict[5] = Photo(placement: 5, url: URL(string: "https://images.unsplash.com/photo-1471623320832-752e8bbf8413?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8Y2l0eSx0cmF2ZWx8fHx8fHwxNjg1NDc2NzQz&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080")!)
            dict[6] = Photo(placement: 6, url: URL(string: "https://images.unsplash.com/photo-1501534664411-d04203736d05?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8Y2l0eSx0cmF2ZWx8fHx8fHwxNjg1NDc2NzU4&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080")!)
            dict[7] = Photo(placement: 7, url: URL(string: "https://images.unsplash.com/photo-1507415953574-2aadbf10e38a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8Y2l0eSx0cmF2ZWx8fHx8fHwxNjg1NDc2Nzc3&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1080")!)

            return dict
        }()
        
        var filters = Filters(seeking: .male)
        filters.isParent = .yes
        filters.maxChildrenn = 5
        filters.childrenRange = .init(min: 1, max: 8)
        filters.minHeight = 56
        filters.relationship = .none
        filters.familyPlans = .wantMore
        filters.politics = .liberal
        
        var user = User(
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
        user.vices = [Vices.snacker, Vices.chocolate, Vices.coffee]
        user.height = 52
        user.relationship = .separated
        user.familyPlans = .wantMore
        user.mobility = .willing
        user.religion = .conservative
        user.politics = .liberal
        return user
    }}
