//
//  AuthState.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import FirebaseAuth

@MainActor
class FirebaseAuthState: ObservableObject {
    enum FirebaseState { case loading, noUser, uid(String) }
    
    @Published var state:FirebaseState = .loading
    private let auth = Auth.auth()
    
    init(){
        auth.addStateDidChangeListener { (auth,user) in
            print("🔥 [Auth] Changed: \(user?.uid ?? "No User")")
            if let uid = user?.uid {
                self.state = .uid(uid)
            } else {
                self.state = .noUser
            }
        }
    }
    
    func signout(){
        try? auth.signOut()
    }
    
    func delete(){
        auth.currentUser?.delete()
        signout()
    }

    var provider: (Provider, String?)? {
        guard let user = auth.currentUser else {return nil }
        let email = user.email
        let phone = user.phoneNumber
        for i in user.providerData {
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    return (.apple, email)
                case "facebook.com":
                    return (.facebook, email ?? phone)
                default:
                    return (.phone, phone)
                }
            }
        }
        return nil
    }
}



