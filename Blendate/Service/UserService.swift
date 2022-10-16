//
//  UserService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import FirebaseFirestore
//import FirebaseEmailAuthUI

import SwiftUI

class UserService {

    let Users = FirebaseManager.instance.Users
    let filemanager = LocalFileService.instance
    
    func updateUser(with user: User) throws {
        let uid = try FirebaseManager.instance.checkUID()
        try? filemanager.store(user: user)
        do {
            try Users.document(uid).setData(from: user)
        } catch {
            throw ErrorInfo(errorDescription: "Server Error", failureReason: "There was an error accessing your device's online storage", recoverySuggestion: "Try again")
        }
    }
    
    
    func update(fcm: String) {
        if let uid = try? FirebaseManager.instance.checkUID() {
            Users.document(uid).updateData(["fcm":fcm])
        }  else {
            printD("Tried to set FCM but no UID")
        }
    }
    
    func fetchUser(from uid: String?) async throws -> User {
        guard let uid = uid else { throw FirebaseError.generic("No UID")}
        print("Path:")
        let firestore = Firestore.firestore()
        let users = firestore.collection("users")
        print(users.document(uid).path)

        let document = try await users.document(uid).getDocument()
        print(document.documentID)
        if let user = try? document.data(as: User.self) {
            var cache = user
            if let prov = FirebaseManager.instance.getProvider(),
               !cache.settings.providers.contains(prov) {
                cache.settings.providers.append(prov)
            }
            cache.details.photos = cache.details.photos.sorted(by: {$0.placement < $1.placement})
            print(cache.fcm)
            return cache
        }
        else {
            throw FirebaseError.decode
            
        }
    }

}

extension UserService {
    
    func sendEmail(to email: String) async throws {
//        guard !email.isBlank, email.isValidEmail
//            else {
//                throw AlertError(errorDescription: "Invalid Email", failureReason: "Please enter a valid email address", helpAnchor: "Please")
//            }
//        var actionCodeSettings: ActionCodeSettings {
//            let actionCodeSettings = ActionCodeSettings()
//            actionCodeSettings.url = URL(string: "https://blendate.page.link/email")
//            actionCodeSettings.handleCodeInApp = true
//            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
//            return actionCodeSettings
//        }
//        
//        do {
//            try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
//            UserDefaults.standard.set(email, forKey: kEmailKey)
//            throw AlertError(errorDescription: "Email Sent", failureReason: "Please check your email for a link to authenticate and sign in, if you don't have an account one will be created for you")
//        } catch {
//            printD(error.localizedDescription)
//            throw AlertError(errorDescription: "Send Error", failureReason: "There was a problem sending your email link, please check the address and try again", recoverySuggestion: "Try Again")
//        }
    }

}
