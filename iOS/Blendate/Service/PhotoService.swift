//
//  PhotoService.swift
//  Blendate
//
//  Created by Michael on 1/21/22.
//

import Foundation
import FirebaseStorageSwift


struct PhotoService {
    let firebase = FirebaseManager.instance

    func uploadPhoto(at index: Int, _ photo: Data) async throws -> Photo {
        guard let uid = FirebaseManager.instance.auth.currentUser?.uid else {throw FirebaseError.generic("No ID")}

        let imageRef = firebase.StorageRef.child("\(uid)/\(index).jpg")
        let metadata = try await imageRef.putDataAsync(photo)
        let url = try await imageRef.downloadURL()
        
        print("Uploaded Photo \(index) to: \(url.absoluteString)")
        return Photo(url: url, placement: index)
    }


//    static func getPhotoURL(at index: Int, _ uid: String? = nil) async throws -> URL {
//        let uid = try check(uid)
//        let imageRef = storageRef.child("\(uid)/\(index).jpg")
//        return try await imageRef.downloadURL()
//    }
//
//    static private func check(_ uid: String?)throws->String{
//        if let uid = uid, !uid.isEmpty {
//            return uid
//        } else {
//            throw FirebaseError.generic("No UID found")
//        }
//    }

    static func photo(_ photos: [Photo], _ index: Int)->Photo? {
        return photos.first(where: {$0.placement == index})
    }
}

