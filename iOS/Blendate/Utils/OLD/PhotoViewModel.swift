////
////  PhotoViewModel.swift
////  Blendate
////
////  Created by Michael Wilkowski on 2/6/23.
////
//
//import Foundation
//import FirebaseStorage
//import SwiftUI
//
//class PhotoViewModel: ObservableObject {
//    @Published var isLoading = false
//
//    private let storage = Storage.storage()
//    var reference: StorageReference { storage.reference() }
//
//    let uid: String
//    
//    init(uid: String){
//        self.uid = uid
//    }
//
//    @MainActor
//    func set(image: UIImage, placement: Int, uid: String) async -> Photo? {
//        guard let data = image.jpegData(compressionQuality: 0.5) else {return nil }
//        do {
//            let photo = try await upload(photo: data, at: placement, for: uid)
//            
//            isLoading = false
//            return photo
//        } catch {
//            print("Photo Upload Error: \(error.localizedDescription)")
//            isLoading = false
//            return nil
//        }
//    }
//    
//    func upload(photo data: Data, at index: Int, for uid: String) async throws -> Photo {
//        let imageRef = reference.child("\(uid)/\(index).jpg")
//        let _ = try await imageRef.putDataAsync(data)
//        let url = try await imageRef.downloadURL()
//
//        print("🔥 [StorageService] Uploaded Photo \(index)\n\t\(url.absoluteString)")
//        return Photo(placement: index, url: url)
//    }
//
////    static func photo(_ photos: [Photo], _ index: Int)->Photo? {
////        return photos.first(where: {$0.placement == index})
////    }
//
//}
