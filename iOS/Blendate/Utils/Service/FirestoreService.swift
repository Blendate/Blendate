//
//  FirebaseService.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation
import FirebaseFirestore


class FirestoreService<Object: FirestoreObject>{
    @Published var fetched: [Object] = []
    @Published var alert: AlertError?
    
    let collection: CollectionReference
    
    init(collection: CollectionReference = Object.collection, listener: Bool = false){
        self.collection = collection
        if listener {
            addSnapshotListener()
        }
    }
    
    func fid(_ id: String?) throws -> String {
        try self.fid(for: nil, id)
    }
    
    func fid(for object: Object?, _ id: String? = nil) throws -> String {
        if let fid = id ?? object?.id as? String {
            return fid
        } else {
            print("Invalid FID for \(Object.self)")
            throw Self.serverError
        }
    }
    
    func create(_ object: Object, fid: String? = nil) throws -> String{
        let fid = fid ?? collection.document().documentID
        print("Creating \(Object.self) \(fid)")
        
        do {
            try collection.document(fid).setData(from: object)
            return fid
        } catch {
            print("Create Error \(Object.self) \(fid)")
            Swift.print(error)
            throw Self.serverError
        }
    }
    
    func update(_ object: Object, _ id: String? = nil) throws {
        let fid: String = try fid(for: object, id)
        print("Updating \(Object.self) \(fid)")
        do {
            try collection.document(fid).setData(from: object)
        } catch {
            print("Update Error \(Object.self) \(fid)")
            Swift.print(error)
            throw Self.serverError
        }
    }
    
    func fetch(fid id: String) async throws -> Object {
        let fid: String = try fid(id)
        
        do {
            let document = try await collection.document(fid).getDocument()
            let object = try document.data(as: Object.self)
            print("Fetched \(Object.self): /\(collection.path)/\(fid)")
            return object
        } catch {
            print("Fetch Error \(Object.self) \(fid)")
            Swift.print(error)
            throw Self.serverError
        }
    }
    
    
    
    func addSnapshotListener(){
        collection.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documentChanges else {return}
            documents.forEach { documentSnapshot in
                if let object = try? documentSnapshot.document.data(as: Object.self) {
                    if documentSnapshot.type == .added {
                        self.fetched.append(object)
                    } else if documentSnapshot.type == .modified,
                              let index = self.fetched.firstIndex(where: {$0.id == object.id}) {
                        self.fetched[index] = object
                    }
                }
            }
        }
    }
    

}




extension FirestoreService where Object == ChatMessage {
    func sendMessage(_ message: Object) throws {
        let _ = try create(message)
        collection.parent?.setData(["lastMessage":message.text])
    }
}


extension FirestoreService: ObservableObject {

    static var serverError: AlertError { AlertError(title: "Server Error", message: "There was an error retreiving your data from the server. Please contact support") }
    private func print(_ string: String){
        let serviceName = String(describing: Self.self)
        let title = "🔥 [\(serviceName)] "
        Swift.print(title + string)
    }
}
//extension FirestoreService {
//    init(collection: String, param: (field: String, contains: String)){
//        self.collection = FireStore.instance.firestore.collection(collection)
//        self.collection
//            .whereField(param.field, arrayContains: param.contains)
//            .addSnapshotListener { snapshot, error in
//                guard error == nil else {
//                    self.print("Listener Error:" + (error?.localizedDescription ?? "Unknown"))
//                    return
//                }
//                snapshot?.documentChanges.forEach({ change in
//                    if change.type == .added {
//                        if let object = try? change.document.data(as: Object.self) {
//                            self.fetched.append(object)
//                        }
//                    } else if change.type == .modified {
//                        if let object = try? change.document.data(as: Object.self) {
//                            if let index = self.fetched.firstIndex(where: {$0.id == object.id}) {
//                                self.fetched[index] = object
//                            }
//                        }
//                    }
//                })
//            }
//
//    }
//}
