//
//  WelcomeViewModel.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/7/23.
//

import SwiftUI
import FirebaseAuth

@MainActor
class FirebaseAuthState: ObservableObject {
    enum State { case loading, noUser, uid(String) }
    
    @Published var state = State.loading
    let auth = Auth.auth()
    
    init(){
        auth.addStateDidChangeListener { (auth,user) in
            if let uid = user?.uid { self.state = .uid(uid) }
            else { self.state = .noUser }
            print("🔥 [Auth] Changed: \(user?.uid ?? "No User")")
        }
    }

    func sendVerifyCode(to phone: String) async {
        let phone = "+\(phone)"
        do {
            let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil)
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        } catch {
            print(error)
        }

    }
    
    func signIn(code: String) async {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {return}

        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: code
        )
        do {
            let _ = try await auth.signIn(with: credential)
        } catch {
            print(error)
        }

    }
    
    func siginIn(appleToken: String, nonce: String) {
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: appleToken,
                                                  rawNonce: nonce)
        Task {
            do {
                let _ = try await auth.signIn(with: credential)
            } catch {
                print(error)
            }
        }

    }
}
