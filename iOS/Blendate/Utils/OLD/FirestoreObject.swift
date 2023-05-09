////
////  FirestoreObject.swift
////  Blendate
////
////  Created by Michael Wilkowski on 2/19/23.
////
//
//import Foundation
//import FirebaseFirestoreSwift
//
//protocol FirestoreObject: Codable, Identifiable {
//    var id: String? {get set}
//    static var collection: String {get}
//}
//
//protocol FirestoreValue: Codable {
//    var value: Any? {get set}
//}
//
//extension FirestoreObject {
//    static func == (lhs: any FirestoreObject, rhs: any FirestoreObject) -> Bool {
//        lhs.id == rhs.id
//    }
//}
//
//extension FireStore {
//    
//    func fetch<O:FirestoreObject>(fid: String) async throws -> O {
//        guard !fid.isEmpty else { throw FireStore.Error.noID }
//        let collection = firestore.collection(O.collection)
//        let document = try await collection.document(fid).getDocument()
//        let object = try document.data(as: O.self)
//        return object
//    }
//    
//    func update<O:FirestoreObject>(_ object: O) throws {
//        guard let fid = object.id, !fid.isEmpty else { throw FireStore.Error.noID }
//        let collection = firestore.collection(O.collection)
//        guard let fid = object.id else { throw Self.Error.noID}
//        try collection.document(fid).setData(from: object)
//    }
//    
//    func create<O:FirestoreObject>(_ object: O, fid: String? = nil) throws -> String {
//        let collection = firestore.collection(O.collection)
//        let fid = fid ?? collection.document().documentID
//        try collection.document(fid).setData(from: object)
//        print("Created \(O.self): \(fid)")
//        return fid
//    }
//}
