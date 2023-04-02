////
////  SignInWithAppleButtonView.swift
////  Blendate
////
////  Created by Michael Wilkowski on 3/7/23.
////
//
//import SwiftUI
//import AuthenticationServices
//
//struct SigninWithAppleButtonView: View {
//    @EnvironmentObject var authManager: FirebaseAuthState
//    @State private var currentNonce: String?
//
//    var body: some View {
//        SignInWithAppleButton(.continue,
//            onRequest: { request in
//                let nonce = Self.randomNonceString()
//                self.currentNonce = nonce
//            request.requestedScopes = [.email, .fullName]
//            request.nonce = Self.sha256(nonce)
//            },
//            onCompletion: { result in
//            switch result {
//            case .success(let authResult):
//                switch authResult.credential {
//                case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                    guard let nonce = currentNonce else { fatalError("Invalid State: A login callback was received, but no login result was sent.")}
//                    guard let appleIDToken = appleIDCredential.identityToken else { return }
//                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {return}
//                    print("Signing In")
//                    authManager.siginIn(appleToken: idTokenString, nonce: nonce)
//                default: break
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//            }
//        )
//        .frame(width: 250, height: 50)
//    }
//}
//
//struct SigninWithAppleButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        SigninWithAppleButtonView()
//            .environmentObject(FirebaseAuthState())
//    }
//}
//
//import CryptoKit
//extension SigninWithAppleButtonView {
//    static func sha256(_ input: String) -> String {
//      let inputData = Data(input.utf8)
//      let hashedData = SHA256.hash(data: inputData)
//      let hashString = hashedData.compactMap {
//        String(format: "%02x", $0)
//      }.joined()
//
//      return hashString
//    }
//    
//    static func randomNonceString(length: Int = 32) -> String {
//      precondition(length > 0)
//      let charset: [Character] =
//        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
//      var result = ""
//      var remainingLength = length
//
//      while remainingLength > 0 {
//        let randoms: [UInt8] = (0 ..< 16).map { _ in
//          var random: UInt8 = 0
//          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
//          if errorCode != errSecSuccess {
//            fatalError(
//              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
//            )
//          }
//          return random
//        }
//
//        randoms.forEach { random in
//          if remainingLength == 0 {
//            return
//          }
//
//          if random < charset.count {
//            result.append(charset[Int(random)])
//            remainingLength -= 1
//          }
//        }
//      }
//
//      return result
//    }
//}
