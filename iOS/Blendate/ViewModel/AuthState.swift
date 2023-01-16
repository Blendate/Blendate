//
//  AuthState.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import Combine
import Firebase
import FirebaseAuth
import FirebaseAuth


@MainActor
class FirebaseAuthState: ObservableObject {
    
    enum FirebaseState {
        case loading, noUser, uid(String)
    }
    
    private let auth = Auth.auth()
    
//    @Published var firUser: FirebaseAuth.User?
    @Published var state:FirebaseState = .loading
    
    private let firebase = Firestore.firestore()
    
    init(){
        auth.addStateDidChangeListener { (auth,user) in
            print("🔥 [Auth] Changed: \(user?.uid ?? "No User")")
//            self.firUser = user
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
}

extension FirebaseAuthState {
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

public enum AuthenticationState {
    case undefined, authenticated, notAuthenticated
}

public class AuthState: ObservableObject {
    @Published public var state: AuthenticationState = .undefined
    @Published public var firUser: Firebase.User? = nil
    @Published public var currentUserUid: String? = nil
    @Published public var email: String = ""
    
    public var cancellables: Set<AnyCancellable> = []
    
    public init(shouldLogoutUponLaunch: Bool = false) {
        startAuthListener()
        logoutIfNeeded(shouldLogoutUponLaunch)
    }
    
    private func startAuthListener() {
        let promise = AuthListener.listen()
        promise.sink { _ in } receiveValue: { result in
            self.firUser = result.user
            self.currentUserUid = result.user?.uid
            self.email = result.user?.email ?? ""
            self.state = result.user != nil ? .authenticated : .notAuthenticated
        }.store(in: &cancellables)
    }
    
    private func logoutIfNeeded(_ shouldLogoutUponLaunch: Bool) {
        if shouldLogoutUponLaunch {
            Task {
                print("AuthState: logging out upon launch...")
                do {
                    try Auth.auth().signOut()
                    print("Logged out")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


public struct AuthListener {
    
    public static func listen() -> PassthroughSubject<AuthListenerResult, Error> {
        let subject = PassthroughSubject<AuthListenerResult, Error>()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            let result = AuthListenerResult(auth: auth, user: user)
            subject.send(result)
        }
        
        return subject
    }
}

public struct AuthListenerResult {
    public let auth: Auth
    public let user: Firebase.User?
}
