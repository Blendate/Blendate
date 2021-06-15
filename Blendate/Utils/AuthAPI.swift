//
//  AuthAPI.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import FirebaseAuth
import Firebase

class AuthAPI {
    
    func signUpGuest(user: User,
        onSuccess: @escaping(_ uid: String)->Void,
                            onError: @escaping(_ errorMessage: String)->Void
    ){
        Auth.auth().signInAnonymously { (authData, error) in
            handleError(error, onError)
            guard let uid = authData?.user.uid else {return}
            var myUser = user
            myUser.uid = uid
            guard let dict = try? myUser.toDic() else {return}
            
            Ref.FIRESTORE_DOCUMENT_USERID(uid).setData(dict) { (error) in
                handleError(error, onError)
                onSuccess(uid)
            }
        }
    }
    
    
//    static func signupUser(phone: String,
//                           verifyCode: String,
//                           verifyID: String,
//                           onSuccess: @escaping(_ user: User)->Void,
//                           onError: @escaping(_ errorMessage: String)->Void
//    ){
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID, verificationCode: verifyCode)
//        Auth.auth().signIn(with: credential) { (authData, error) in
//            handleError(error, onError)
//
//            guard let uid = authData?.user.uid else {return}
//
//            Api.User.createFirebaseDocument(uid: uid, onSuccess: onSuccess, onError: onError)
//        }
//
//    }
//
//    static func loginPhone(phone: String,
//                           verifyCode: String,
//                           verifyID: String,
//                           onSuccess: @escaping(_ user: User)->Void,
//                           onError: @escaping(_ errorMessage: String)->Void
//    ){
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID, verificationCode: verifyCode)
//        Auth.auth().signIn(with: credential) { (authData, error) in
//            handleError(error, onError)
//
//            guard let uid = authData?.user.uid else {return}
//
//            Api.User.getUserByID(uid: uid, onSuccess: onSuccess, onError: onError)
//
//        }
//    }
//
//
//    static func sendVerifyCode(phone: String,
//                        completed: @escaping(_ verifyID: String)->Void,
//                        onError: @escaping(_ errorMessage: String)->Void
//    ){
//        let phoneNumber = "+1"+phone
//        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
//            handleError(error, onError)
//            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
//            guard let id = verificationID else {return}
//            completed(id)
//        }
//    }
}
