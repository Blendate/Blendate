//
//  FirebaseService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    let Users: CollectionReference
    let Chats: CollectionReference
//    let StorageRef: StorageReference
    
    func Passes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("passes")
    }
    
    func Likes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("likes")
    }
    
    static let instance = FirebaseManager()
    
    private override init(){
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        self.Users = firestore.collection("users")
        self.Chats = firestore.collection("chats")
//        self.StorageRef = storage.reference()
        super.init()
    }
    
    static func getUsersID(userId1: String, userId2: String) -> String {
        userId1 > userId2 ? userId1 + userId2 : userId2 + userId1
    }
    
    
    func checkUID() throws -> String {
        guard let uid = auth.currentUser?.uid else {throw FirebaseError.generic("No UID")}
        return uid
    }

    
    func signout(){
        try? auth.signOut()
    }

}

extension FirebaseManager {
    func getProviders() -> [Provider]? {
        guard let user = auth.currentUser else {return nil }
        
        var providers = [Provider]()
        for i in user.providerData {
            printD("Provider: \(i.providerID)\nEmail: \(i.email ?? "None")")
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    providers.append(Provider(type: .apple, email: i.email) )
                case "facebook.com":
                    providers.append(Provider(type: .facebook, email: i.email) )
                case "google.com":
                    providers.append(Provider(type: .google, email: i.email) )
                case "twitter.com":
                    providers.append(Provider(type: .twitter, email: i.email) )
                default:
                    providers.append(Provider(type: .email, email: i.email) )
                }
            }
        }
        return providers
    }
    
    
    func getProvider() -> Provider? {
        guard let user = auth.currentUser else {return nil }

        for i in user.providerData {
            print(i.providerID)
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    return Provider(type: .apple, email: i.email ?? "")
                case "facebook.com":
                    return Provider(type: .facebook, email: i.email ?? "")
                case "google.com":
                    return Provider(type: .google, email: i.email ?? "")
                case "twitter.com":
                    return Provider(type: .twitter, email: i.email ?? "")
                default:
                    return Provider(type: .email, email: i.email ?? "")
                }
            } else {
                return nil
            }
        }
        return nil
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

        do {
            try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
            UserDefaults.standard.set(email, forKey: kEmailKey)
            throw AlertError(errorDescription: "Email Sent", failureReason: "Please check your email for a link to authenticate and sign in, if you don't have an account one will be created for you")
        } catch {
            print("Email Error: \(error.localizedDescription)")
//            printD(error.localizedDescription)
//            throw AlertError(errorDescription: "Send Error", failureReason: "There was a problem sending your email link, please check the address and try again", recoverySuggestion: "Try Again")
        }
    }
}
