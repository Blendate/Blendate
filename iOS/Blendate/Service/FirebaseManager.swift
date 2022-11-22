//
//  FirebaseService.swift
//  Blendate
//
//  Created by Michael on 2/12/22.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class FirebaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    let Users: CollectionReference
    let Chats: CollectionReference
    let Community: CollectionReference

    let StorageRef: StorageReference
    
    func Passes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("passes")
    }
    
    func Likes(for uid: String) -> CollectionReference {
        return Users.document(uid).collection("likes")
    }
    
    static let instance = FirebaseManager()
    
    private override init(){

//        FirebaseApp.configure()

        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        Users = firestore.collection("users")
        Chats = firestore.collection("chats")
        Community = firestore.collection("community")

        StorageRef = storage.reference()
        super.init()
    }
    
    static func getUsersID(userId1: String, userId2: String) -> String {userId1 > userId2 ? userId1 + userId2 : userId2 + userId1}
    
    func getProviders() -> [Provider]? {
        guard let user = auth.currentUser else {return nil }
        
        var providers = [Provider]()
        for i in user.providerData {
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
    
    func checkUID() throws -> String {
        guard let uid = auth.currentUser?.uid else {throw FirebaseError.generic("No UID")}
        return uid
    }
    
    func getProvider() -> Provider? {
        guard let user = auth.currentUser else {return nil }

        for i in user.providerData {
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
    
    func signout(){
        try? auth.signOut()
    }

}


enum FirebaseError: LocalizedError{
    case decode
    case server
    case generic(String)
    
    
    var errorDescription: String? {
        switch self {
        case .decode:
            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
        case .server:
            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
        case .generic(let string):
            return NSLocalizedString(string, comment: "Firebase Error")
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .decode:
            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
        case .server:
            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
        case .generic(let string):
            return NSLocalizedString(string, comment: "Firebase Error")
        }
    }
}



class FirebaseService<Object: Codable> where Object: Identifiable {
    
    let collection: CollectionReference
    let firebase: Firestore = FirebaseManager.instance.firestore
    private let serviceName: String
    
    var Users: CollectionReference {
        firebase.collection("users")
    }
    
    func Swipes(for uid: String, _ swipe: Swipe) -> CollectionReference {
        return Users.document(uid).collection(swipe.rawValue)
        
    }
    
    init(collection: String){
        self.collection = firebase.collection(collection)
        self.serviceName = collection.capitalized
    }
    
    private func fid(_ object: Object?, _ id: String?) throws -> String {
        let fid = id ?? object?.id as? String
        guard let fid = fid else { throw ErrorInfo() }
        return fid
    }
    
    func create(_ object: Object) throws {
        let id = collection.document().documentID
        try update(object, id)
    }
    
    func update(_ object: Object, _ id: String? = nil) throws {
        let fid: String = try fid(object, id)
        devPrint("Updating \(Object.Type.self) \(fid)")
        do {
            try collection.document(fid).setData(from: object)
        } catch {
            devPrint("Update Error \(Object.Type.self) \(fid)")
            print(error)
            throw ErrorInfo(
                errorDescription: "Server Error",
                failureReason: "There was an error accessing your device's online storage",
                recoverySuggestion: "Try again"
            )
        }
    }
    
    func fetch(fid id: String? = nil) async throws -> Object {
        let fid: String = try fid(nil,id)
        
        devPrint("Fetching \(Object.Type.self) \(fid)")
        do {
            let document = try await collection.document(fid).getDocument()
            let object = try document.data(as: Object.self)
            
            devPrint("Fetched \(Object.Type.self) \(fid)")
            return object
        } catch {
            throw FirebaseError.decode
        }
    }
    
    func getHistory(for uid: String, _ swipe: Swipe) async -> [String] {
        let documents = try? await Swipes(for: uid, .like).getDocuments().documents
        let array = documents?.compactMap{$0.documentID} ?? []
        return array
    }
    
    func allSwipes(for uid: String) async -> [String] {
        let likes = await getHistory(for: uid, .like)
        let passes = await getHistory(for: uid, .pass)
        let combine = likes + passes
        return combine.isEmpty ? ["empty"] : combine
    }
    
    func devPrint(_ string: String){
        let devString = "🔥 [\(serviceName)Service] "
        print(devString + string)
    }
    
}

extension FirebaseService {
    static func getUsersID(userId1: String, userId2: String) -> String {
        userId1 > userId2 ? userId1 + userId2 : userId2 + userId1
    }
}


//
//func sendEmail(to email: String) async throws {
//    guard !email.isBlank, email.isValidEmail
//        else {
//            throw AlertError(errorDescription: "Invalid Email", failureReason: "Please enter a valid email address", helpAnchor: "Please")
//        }
//    var actionCodeSettings: ActionCodeSettings {
//        let actionCodeSettings = ActionCodeSettings()
//        actionCodeSettings.url = URL(string: "https://blendate.page.link/email")
//        actionCodeSettings.handleCodeInApp = true
//        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
//        return actionCodeSettings
//    }
//
//    print("Sending Email to \(email)")
//    do {
//        try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
//        UserDefaults.standard.set(email, forKey: kEmailKey)
//        throw AlertError(errorDescription: "Email Sent", failureReason: "Please check your email for a link to authenticate and sign in, if you don't have an account one will be created for you")
//    } catch {
//        print("Email Link Error: \(error.localizedDescription)")
//        throw AlertError(errorDescription: "Send Error", failureReason: "There was a problem sending your email link, please check the address and try again", recoverySuggestion: "Try Again")
//    }
//}
