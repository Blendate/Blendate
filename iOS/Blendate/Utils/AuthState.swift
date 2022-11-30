//
//  AuthState.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import Combine
import Firebase
import FirebaseAuth

public enum AuthenticationStateValue {
    case undefined, authenticated, notAuthenticated
}
public class AuthState: ObservableObject {
    
    @Published public var user: Firebase.User? = nil
    @Published public var value: AuthenticationStateValue = .undefined
    @Published public var currentUserUid: String? = nil
    @Published public var email: String = ""
    
    public var cancellables: Set<AnyCancellable> = []
    
    public init(shouldLogoutUponLaunch: Bool = false) {
        print("AuthState init")
        startAuthListener()
        logoutIfNeeded(shouldLogoutUponLaunch)
    }
    
    private func startAuthListener() {
        let promise = AuthListener.listen()
        promise.sink { _ in } receiveValue: { result in
            self.user = result.user
            self.currentUserUid = result.user?.uid
            self.email = result.user?.email ?? ""
            self.value = result.user != nil ? .authenticated : .notAuthenticated
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
