//
//  FirebaseService.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation
import FirebaseFirestore

class FirestoreService<Object: Codable> where Object: Identifiable {
    @Published var fetched: [Object] = []
    @Published var object: Object?
    
    @Published var alert: AlertError?
    
    let collection: CollectionReference
    static var kUsers: String { "mock_users" }
    static var kChats: String { "chats" }
    static var kCommunity: String { "community" }
    static var kSettings: String { "settings" }
    
    init(collection: CollectionReference, listener: Bool = false){
        self.collection = collection
        if listener {
            addSnapshotListener()
        }
    }
    
    init(collection: String, param: (field: String, contains: String)){
        self.collection = FireStore.instance.firestore.collection(collection)
        self.collection
            .whereField(param.field, arrayContains: param.contains)
            .addSnapshotListener { snapshot, error in
                guard error == nil else {
                    self.print("Listener Error:" + (error?.localizedDescription ?? "Unknown"))
                    return
                }
                snapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        if let object = try? change.document.data(as: Object.self) {
                            self.fetched.append(object)
                        }
                    } else if change.type == .modified {
                        if let object = try? change.document.data(as: Object.self) {
                            if let index = self.fetched.firstIndex(where: {$0.id == object.id}) {
                                self.fetched[index] = object
                            }
                        }
                    }
                })
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

    
    @MainActor
    func fetch() async {
        let object = try? await self.fetch(fid: nil)
        self.object = object
    }
    

}
extension FirestoreService {
    
    func fid(_ id: String?) throws -> String {
        try self.fid(nil, id)
    }
    
    func fid(_ object: Object?, _ id: String? = nil) throws -> String {
        if let fid = id ?? object?.id as? String {
            return fid
        } else {
            print("Invalid FID for \(Object.self)")
            throw Self.serverError
        }
    }
    
    func create(_ object: Object, id: String? = nil) throws {
        let id = object.id as? String ?? collection.document().documentID
        let fid: String = try fid(object, id)
        print("Creating \(Object.self) \(fid)")
        do {
            try collection.document(fid).setData(from: object)
        } catch {
            print("Create Error \(Object.self) \(fid)")
            Swift.print(error)
            throw Self.serverError
        }
    }
    
    
    
    func update(_ object: Object, _ id: String? = nil) throws {
        let fid: String = try fid(object, id)
        print("Updating \(Object.self) \(fid)")
        do {
            try collection.document(fid).setData(from: object)
        } catch {
            print("Update Error \(Object.self) \(fid)")
            Swift.print(error)
            throw Self.serverError
        }
    }
    
    func fetch(fid id: String?) async throws -> Object {
        let fid: String = try fid(nil,id)
        
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

}

extension FirestoreService {
    
    static var Users: CollectionReference {
        FireStore.instance.firestore.collection(Self.kUsers)
    }
    
    static var Settings: CollectionReference {
        FireStore.instance.firestore.collection(Self.kSettings)
    }
    
    static var Matches: CollectionReference {
        FireStore.instance.firestore.collection(Self.kChats)
    }
    
    static var Community: CollectionReference {
        FireStore.instance.firestore.collection(Self.kCommunity)
    }
    
    static func Swipes(for uid: String, _ swipe: Swipe) -> CollectionReference {
        return Users.document(uid).collection(swipe.rawValue)
    }
    
    static func Collection<C:Convo>(for convo:C) -> CollectionReference {
        if C.self == Conversation.self {
            return Matches
        } else {
            return Community
        }
    }
    
    static func Messages<C:Convo>(for convo: C) -> CollectionReference {
        #warning("fix the optional")
        let fid = convo.id!
        if C.self == Conversation.self {
            return Matches.document(fid).collection("chats")
        } else {
            return Community.document(fid).collection("chats")
        }
    }
    
    func Messages(for fid: String) -> CollectionReference {
        return collection.document(fid).collection("chats")
    }
    
    static func getHistory(for uid: String, _ swipe: Swipe) async -> [String] {
        let documents = try? await Swipes(for: uid, .like).getDocuments().documents
        let array = documents?.compactMap{$0.documentID} ?? []
        return array
    }
    
    static func allSwipes(for uid: String) async -> [String] {
        var combine: [String] = []
        for swipe in Swipe.allCases {
            let history = await getHistory(for: uid, swipe)
            combine.append(contentsOf: history)
        }
        return combine.isEmpty ? ["empty"] : combine
    }
    
}

extension FirestoreService {
    
    static var serverError: AlertError { AlertError(title: "Server Error", message: "There was an error retreiving your data from the server. Please contact support") }
}

class FireStore: NSObject {
    let firestore: Firestore
    
    static let instance = FireStore()
    
    private override init(){
        self.firestore = Firestore.firestore()
        super.init()
    }
    
    static func getUsersID(userId1: String, userId2: String) -> String {
        userId1 > userId2 ? userId1 + userId2 : userId2 + userId1
    }
}


extension FirestoreService: ObservableObject {
    private func print(_ string: String){
        let serviceName = String(describing: Self.self)
        let title = "🔥 [\(serviceName)] "
        Swift.print(title + string)
    }
}
//
//func addSnapshotListener(){
//    collection.addSnapshotListener { (querySnapshot, error) in
//    guard let documents = querySnapshot?.documents else { self.print("No documents");return}
//
//    self.fetched = documents.compactMap { queryDocumentSnapshot -> Object? in
//        return try? queryDocumentSnapshot.data(as: Object.self)
//    }
//  }
//}
