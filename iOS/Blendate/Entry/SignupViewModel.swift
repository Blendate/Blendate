//
//  SignupViewModel.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/9/23.
//

import Foundation

class SignupViewModel: ObservableObject {
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var name = Name(first: "", last: "")
    @Published var birthday = Date.now
    @Published var gender: Gender = .none
    @Published var seeking: Gender = .none
    @Published var isParent: Parent = true
    @Published var children: Children = 1
    @Published var childrenRange: KidAgeRange = .defaultValue
    @Published var location = Location(name: "", lat: 0, lon: 0)
    @Published var maxDistance: Int = 50
    @Published var about: Bio = ""
    @Published var photos: [Int:Photo] = [:]
    let uid: String
    
    init(uid: String) {
        self.uid = uid
    }
}

enum Onboarding: String, CaseIterable {
    case name, birthday, gender, seeking, isParent, children, childrenRange, location, about, photos
    
    var title: String? {
        switch self {
        case .name, .about, .photos, .location: return nil
        case .isParent:
            return "Are you a parent?"
        case .children:
            return "How many Children?"
        case .childrenRange:
            return "Children's age range"
        default: return self.rawValue.capitalized

        }
    }
    
    var svg: String? {
        switch self {
        case .name:
            return Name.svgImage
        case .birthday:
            return "Birthday"
        case .gender:
            return Gender.svgImage
        case .seeking:
            return "Interested"
        case .isParent, .children, .childrenRange:
            return Parent.systemImage
        default: return nil
        }
    }
}
