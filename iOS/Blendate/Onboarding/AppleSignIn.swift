//
//  AppleSignIn.swift
//  Blendate
//
//  Created by Michael on 5/31/23.
//

import SwiftUI
import CryptoKit
import FirebaseAuth
import AuthenticationServices

class AppleSignIn: ObservableObject {
    @Published var currentNonce:String?
    
    enum Error: Swift.Error {
        case token
    }
    
    func nonce(request: ASAuthorizationAppleIDRequest) {
        let nonce = randomNonceString()
        self.currentNonce = nonce
        request.requestedScopes = [.fullName]
        request.nonce = self.sha256(nonce)
    }
    
    func handleResult(result: Result<ASAuthorization, Swift.Error>) throws {
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                guard let nonce = currentNonce else { throw Error.token }
                guard let appleIDToken = appleIDCredential.identityToken else { throw Error.token }
                guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else { throw Error.token }
                let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                
                if let firstName = appleIDCredential.fullName?.givenName {
                    UserDefaults.standard.setValue(firstName, forKey: "firstName")
                }
                if let lastName = appleIDCredential.fullName?.familyName {
                    UserDefaults.standard.setValue(lastName, forKey: "lastName")
                }

                Auth.auth().signIn(with: credential) { (authResult, error) in

                }
            default: break
            }
        default: break
        }
    }

    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
        }.joined()

        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
}
