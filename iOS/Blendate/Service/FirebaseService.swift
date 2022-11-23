//
//  FirebaseService.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase


class FirebaseService<Object: Codable> where Object: Identifiable {
    
    
    let collection: CollectionReference
    private let serviceName: String
        
    init(collection: String){
        self.collection = FireStore.instance.firestore.collection(collection)
        self.serviceName = collection.capitalized
    }
    
    func fid(_ object: Object?, _ id: String?) throws -> String {
        let fid = id ?? object?.id as? String
        guard let fid = fid
            else {
            devPrint("Invalid FID for \(Object.self)")
                throw Self.serverError
            }
        return fid
    }
    
    func create(_ object: Object, id: String? = nil) throws {
        let id = object.id as? String ?? collection.document().documentID
        let fid: String = try fid(object, id)
        devPrint("Creating \(Object.self) \(fid)")
        do {
            try collection.document(fid).setData(from: object)
        } catch {
            devPrint("Create Error \(Object.self) \(fid)")
            print(error)
            throw Self.serverError
        }
    }
    
    func update(_ object: Object, _ id: String? = nil) throws {
        let fid: String = try fid(object, id)
        devPrint("Updating \(Object.self) \(fid)")
        do {
            try collection.document(fid).setData(from: object)
        } catch {
            devPrint("Update Error \(Object.self) \(fid)")
            print(error)
            throw Self.serverError
        }
    }
    
    func fetch(fid id: String? = nil) async throws -> Object {
        let fid: String = try fid(nil,id)
        
        devPrint("Fetching \(Object.self): \(collection.path)/ \(fid)")
        do {
            let document = try await collection.document(fid).getDocument()
            let object = try document.data(as: Object.self)
            return object
        } catch {
            devPrint("Fetch Error \(Object.self) \(fid)")
            print(error)
            throw Self.serverError
        }
    }

    func devPrint(_ string: String, _ error: Bool = false){
        let fire = "🔥"
        let warning = "⚠️"
        let emoji = error ? fire+warning : fire
        let devString = "\(emoji) [\(serviceName)Service] "
        print(devString + string)
    }
}

extension FirebaseService {
    
    var Users: CollectionReference {
        FireStore.instance.firestore.collection("users")
    }
    
    func Swipes(for uid: String, _ swipe: Swipe) -> CollectionReference {
        return Users.document(uid).collection(swipe.rawValue)
        
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
    
}

extension FirebaseService {
    static func getUsersID(userId1: String, userId2: String) -> String {
        userId1 > userId2 ? userId1 + userId2 : userId2 + userId1
    }
    
    static var serverError: AlertError { AlertError(title: "Server Error", message: "There was an error retreiving your data from the server. Please contact support") }
}

class FireStore: NSObject {
    let firestore: Firestore
    
    static let instance = FireStore()
    
    private override init(){
        self.firestore = Firestore.firestore()
        super.init()
    }
}


