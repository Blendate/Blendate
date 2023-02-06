//
//  StorageService.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation
import FirebaseStorage

class PhotoService {
    
    private let storage = Storage.storage()
    var reference: StorageReference { storage.reference() }
    
    
    func upload(photo data: Data, at index: Int, for uid: String) async throws -> Photo {
        let imageRef = reference.child("\(uid)/\(index).jpg")
        let metadata = try await imageRef.putDataAsync(data)
        let url = try await imageRef.downloadURL()
        
        print("🔥 [StorageService] Uploaded Photo \(index)\n\t\(url.absoluteString)")
        return Photo(placement: index, url: url)
    }
    
    static func photo(_ photos: [Photo], _ index: Int)->Photo? {
        return photos.first(where: {$0.placement == index})
    }

}
