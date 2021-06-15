//
//  UserAPI.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import UIKit


func handleError(_ error: Error?, _ onError: @escaping(_ errorMessage: String)->Void){
    if error != nil {
        print(error!.localizedDescription)
        onError(error!.localizedDescription)
        return
    }
}

class UserAPI {
    
    func setUserData(uid: String, user: User,
                        onSuccess: @escaping()->Void,
                        onError: @escaping(_ errorMessage: String)->Void){
                
        guard let dict = try? user.toDic() else {return}
        Ref.FIRESTORE_DOCUMENT_USERID(uid).setData(dict) { (error) in
            handleError(error, onError)
            onSuccess()
        }
        
    }
    

    
    func saveImages(uid: String, profileImage: UIImage, coverPhoto: UIImage, images: [UIImage], onSuccess: @escaping(_ urlStrings: [URL]) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        guard let profileImageData = profileImage.jpegData(compressionQuality: 0.5) else {return}
        let profileRef = Ref.STORAGE_PROFILE(uid: uid)
        profileRef.putData(profileImageData, metadata: metadata) { (storageMetadata, error) in
            handleError(error, onError)
            
            profileRef.downloadURL { (url, error) in
                if let metaImageUrl = url {
                    print(metaImageUrl)
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.commitChanges { (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }

                    let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(uid)
                    firestoreUserId.updateData(["profileImage":"\(metaImageUrl)"]){(error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                            return
                        }
                    }
                }
            }
            
            guard let coverImageData = coverPhoto.jpegData(compressionQuality: 0.5) else {return}
            let coverRef = Ref.STORAGE_COVER(uid: uid)
            coverRef.putData(coverImageData, metadata: metadata) { (storageMetadata, error) in
                handleError(error, onError)
                
                coverRef.downloadURL { (url, error) in
                    if let metaImageUrl = url {
                        print(metaImageUrl)
                        let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(uid)
                        firestoreUserId.updateData(["coverPhoto":"\(metaImageUrl)"]){(error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                }
                
                if images.count > 0 {
                    for i in 0...images.count {
                        guard let imageData = images[i].jpegData(compressionQuality: 0.5) else {return}
                        let storageAvatarRef = Ref.STORAGE_IMAGES(uid: uid, image: i)
                        storageAvatarRef.putData(imageData, metadata: metadata) { (storageMetadata, error) in
                            handleError(error, onError)
                            
                        }
                    }
                }
                let firestoreUserId = Ref.FIRESTORE_DOCUMENT_USERID(uid)
                firestoreUserId.updateData(["completeSignup":true]){(error) in
                    handleError(error, onError)
                    onSuccess([])
                }
            }
        }
    }
    
    
    
    
    
//    func getLineup(onSuccess: @escaping([User]) -> Void, onError: @escaping(_ errorMessage: String) -> Void, newInboxMessage: @escaping(User) -> Void, listener: @escaping(_ listenerHandle: ListenerRegistration) -> Void) {
//        
//        guard let uid = Auth.auth().currentUser?.uid else {return}
//        let listenerFirestore = Ref.FIRESTORE_COLLECTION_INBOX_MESSAGES(userId: uid).order(by: "date", descending: true).addSnapshotListener { (querySnapshot, error) in
//            guard let snapshot = querySnapshot else {
//                return
//            }
//            
//            var inboxMessages = [InboxMessage]()
//            
//            snapshot.documentChanges.forEach { (documentChange) in
//                switch documentChange.type {
//                case .added:
//                    let dict = documentChange.document.data()
//                    guard let decoderInboxMessage = try? InboxMessage(fromDict: dict) else {return}
//                    newInboxMessage(decoderInboxMessage)
//                    inboxMessages.append(decoderInboxMessage)
//                    
//                case .modified:
//                    print("type: modified")
//                case .removed:
//                    print("type: removed")
//                }
//            }
//            
//            onSuccess(inboxMessages)
//            
//        }
//        
//        listener(listenerFirestore)
//    }
    
}
