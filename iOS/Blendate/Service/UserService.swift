//
//  UserService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseEmailAuthUI

import SwiftUI

class UserService {

    let Users = FirebaseManager.instance.Users
    let filemanager = LocalFileService.instance
    
    func update(_ user: User) throws {
        let uid = try FirebaseManager.instance.checkUID()
        try? filemanager.store(user: user)
        print("Updating User: \(uid)")
        do {
            try Users.document(uid).setData(from: user)
        } catch {
            print("Update User Error: \(error.localizedDescription)")
            throw ErrorInfo(errorDescription: "Server Error", failureReason: "There was an error accessing your device's online storage", recoverySuggestion: "Try again")
        }
    }
    
    func update(fcm: String) {
        if let uid = try? FirebaseManager.instance.checkUID() {
            Users.document(uid).updateData(["fcm":fcm])
        }  else {
            print("Update FCM Failed, no UID")
        }
    }
    
    func fetchUser(from uid: String) async throws -> User {
        print("Fetching User: \(uid)")
        let document = try await Users.document(uid).getDocument()
        guard let cache = try document.data(as: User.self)
            else { throw FirebaseError.decode }
        let user = getProviders(for: cache)
        print("User Onboarded: \(user.settings.onboarded)")
        return user
    }
    
    func sendEmail(to email: String) async throws {
        guard !email.isBlank, email.isValidEmail
            else {
                throw AlertError(errorDescription: "Invalid Email", failureReason: "Please enter a valid email address", helpAnchor: "Please")
            }
        var actionCodeSettings: ActionCodeSettings {
            let actionCodeSettings = ActionCodeSettings()
            actionCodeSettings.url = URL(string: "https://blendate.page.link/email")
            actionCodeSettings.handleCodeInApp = true
            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
            return actionCodeSettings
        }

        print("Sending Email to \(email)")
        do {
            try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
            UserDefaults.standard.set(email, forKey: kEmailKey)
            throw AlertError(errorDescription: "Email Sent", failureReason: "Please check your email for a link to authenticate and sign in, if you don't have an account one will be created for you")
        } catch {
            print("Email Link Error: \(error.localizedDescription)")
            throw AlertError(errorDescription: "Send Error", failureReason: "There was a problem sending your email link, please check the address and try again", recoverySuggestion: "Try Again")
        }
    }
    
    private func getProviders(for user: User) -> User {
        var user = user
        if let prov = FirebaseManager.instance.getProvider(),
           !user.settings.providers.contains(prov) {
            user.settings.providers.append(prov)
        }
        user.details.photos = user.details.photos.sorted(by: {$0.placement < $1.placement})
        return user
    }

}
