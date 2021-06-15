//
//  Session.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/15/21.
//

import Foundation
import FirebaseAuth
import UIKit

class ImagePickerModel: ObservableObject {
    @Published var profileImage: UIImage?
    @Published var coverPhoto: UIImage?
    @Published var photos: [Int:UIImage] = [:]
    @Published var images: [UIImage] = []
}

class Session: ObservableObject {
    @Published var currentView: InitialScreen = .loading

    @Published var user: User = User(id: "")
    @Published var selectedTab: Int = 0
    @Published var lineup: [User] = [Dummy.user, Dummy.user2]

    
//    init() {
//        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
//            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
//            currentView = .onboarding
//        }
//    }
    
    var handle: AuthStateDidChangeListenerHandle?
    
    func listenAuthenticationState(){
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                Ref.FIRESTORE_DOCUMENT_USERID(user.uid).getDocument { (document, error) in
                    if let dict = document?.data() {
                        guard let decodedUser = try? User(fromDict: dict) else {return}
                        self.user = decodedUser
                        self.currentView = .session
                    }
                }
            } else {
                print("User logged out")
                self.user = User(id: "")
                self.currentView = .welcome
            }
        })
    }
    
//    private func load(user: User){
//            Ref.FIRESTORE_DOCUMENT_USERID(user.uid).getDocument { (document, error) in
//                if let dict = document?.data() {
//                    guard let decodedUser = try? User(fromDict: dict) else {return}
//                    self.user = decodedUser
//                    self.currentView = .session
//                }
//            }
//    }
    
    func logout(){
        do {
            try Auth.auth().signOut()
            self.currentView = .welcome
        } catch {
            
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
