//
//  PhotoViewModel.swift
//  Blendate
//
//  Created by Michael on 1/21/22.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorageSwift

class PhotoViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: PhotoPicker.Source = .library
}

enum PhotoPicker {
    enum Source: String {
        case library, camera
    }
    
    static func checkPermissions() -> Bool {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            return true
        } else {
            return false
        }
    }
}



struct PhotoService {
    static let storage = Storage.storage()
    static let storageRef = storage.reference()
    static let userCollection = Firestore.firestore().collection("users")

    
    static func uploadPhoto(at index: Int, _ photo: Data) async throws -> Photo {
        guard let uid = FirebaseManager.instance.auth.currentUser?.uid else {throw FirebaseError.generic("No ID")}

        let imageRef = storageRef.child("\(uid)/\(index).jpg")
        let metadata = try await imageRef.putDataAsync(photo)
        print(metadata)
        let url = try await imageRef.downloadURL()
        
        return Photo(url: url, placement: index)
    }

    
    static func getPhotoURL(at index: Int, _ uid: String? = nil) async throws -> URL {
        let uid = try check(uid)
        let imageRef = storageRef.child("\(uid)/\(index).jpg")
        return try await imageRef.downloadURL()
    }
    
    static private func check(_ uid: String?)throws->String{
        if let uid = uid, !uid.isEmpty {
            return uid
        } else {
            throw FirebaseError.generic("No UID found")
        }
    }
    
    static func photo(_ photos: [Photo], _ index: Int)->Photo? {
        return photos.first(where: {$0.placement == index})
    }
}

