//
//  SignupViewModel.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/9/23.
//

import Foundation

class SignupViewModel: ObservableObject {
    
    @Published var birthday = Birthday(date: Date.youngestBirthday)
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
        print(UserDefaults.standard.string(forKey: "firstName") ?? "FirstName")
        print(UserDefaults.standard.string(forKey: "lastName") ?? "LastName")

        self.uid = uid
    }
    
    func valid(for path: Onboarding) -> Bool {
        switch path {
        case .birthday:
            return birthday.isValid
        case .gender:
            return gender.isValid
        case .seeking:
            return seeking.isValid
        case .isParent:
            return true
        case .children:
            return children.isValid
        case .childrenRange:
            return childrenRange.isValid
        case .location:
            return location.isValid
        case .about:
            return about.isValid
        case .photos:
            return photos[0]?.url != nil && photos[1]?.url != nil
        }
    }
    
    func createDoc() throws -> (String, User, User.Settings) {
        guard let firstName = UserDefaults.standard.string(forKey: "firstName"),
              let lastname = UserDefaults.standard.string(forKey: "lastName") else { throw SignupView.Error() }
        let user = User (
            firstname: firstName,
            lastname: lastname,
            birthday: birthday.date,
            gender: gender,
            isParent: isParent,
            children: children,
            childrenRange: childrenRange,
            bio: about,
            location: location,
            photos: photos,
            filters: Filters(seeking: seeking)
        )
        let userCollection = FireStore.shared.firestore.collection(CollectionPath.Users)
        try userCollection.document(uid).setData(from: user)
        
        let settings = User.Settings()
        let settingsCollection = FireStore.shared.firestore.collection(CollectionPath.Settings)
        try userCollection.document(uid).setData(from: settings)

        return (uid, user, settings)

    }
    

}

enum Onboarding: String, CaseIterable {
    case birthday, gender, seeking, isParent, children, childrenRange, location, about, photos
    
    var title: String? {
        switch self {
        case .about, .photos, .location: return nil
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
        case .birthday:
            return "Birthday"
        case .gender:
            return Gender.svgImage
        case .seeking:
            return "Interested"
        case .isParent, .children, .childrenRange:
            return Parent.svgImage
        default: return nil
        }
    }
}
