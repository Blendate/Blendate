//
//  MyDefaults.swift
//  Blendate
//
//  Created by Michael on 1/21/22.
//

import Foundation

struct MyUserDefaults {

    static private let userKey = "userKey"

    static var user: User? = {

        guard let data = UserDefaults.standard.data(forKey: userKey) else { return nil }
        if let user = try? JSONDecoder().decode(User.self, from: data) {
            return user
        } else {return nil}
    }()
    {
        didSet {
            guard let data = try? JSONEncoder().encode(user) else { return }
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }

    static func save(_ user: User) {
        self.user = user
    }

    static func load() -> User? {
        return self.user
    }
    
    static func remove() {
        UserDefaults.standard.removeObject(forKey: userKey)
    }
}


//struct TokenDefaults {
//
//    static private let tokensKey = "TokensKey"
//
//    static var tokens: UserTokens? = {
//
//        guard let data = UserDefaults.standard.data(forKey: tokensKey) else { return nil }
//        if let user = try? JSONDecoder().decode(UserTokens.self, from: data) {
//            return user
//        } else {return nil}
//    }()
//    {
//        didSet {
//            guard let data = try? JSONEncoder().encode(tokens) else { return }
//            UserDefaults.standard.set(data, forKey: tokensKey)
//        }
//    }
//}
