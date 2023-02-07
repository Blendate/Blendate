//
//  PhotoViewModel.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/6/23.
//

import Foundation
import FirebaseStorage
import SwiftUI

class PhotoViewModel: ObservableObject {

    @Published var photo: Photo
    @Published var isLoading = false
    
    init(photo: Photo){
        self.photo = photo
    }
    
    private let storage = Storage.storage()
    var reference: StorageReference { storage.reference() }


    func set(image: UIImage, uid: String) async {
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}
        do {
            let photo = try await upload(photo: data, at: photo.placement, for: uid)

            self.photo = photo
            isLoading = false
        } catch {
            print("Photo Upload Error: \(error.localizedDescription)")
            isLoading = false
        }
    }
    
    func upload(photo data: Data, at index: Int, for uid: String) async throws -> Photo {
        let imageRef = reference.child("\(uid)/\(index).jpg")
//        let metadata = try await imageRef.putDataAsync(data)
        let url = try await imageRef.downloadURL()

        print("🔥 [StorageService] Uploaded Photo \(index)\n\t\(url.absoluteString)")
        return Photo(placement: index, url: url)
    }

    static func photo(_ photos: [Photo], _ index: Int)->Photo? {
        return photos.first(where: {$0.placement == index})
    }

}
