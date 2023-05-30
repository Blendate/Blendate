//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/3/23.
//

import SwiftUI
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    
    @Published var user: User
    @Published var settings = User.Settings()
    @Published var fetching = true
    @Published var error: (any ErrorAlert)?
    
    let uid: String
    
    init(uid: String, user: User){
        self.uid = uid
        self.user = user
    }
    
    func save()  {
        do {
            let collection = FireStore.shared.firestore.collection(CollectionPath.Users)
            try collection.document(uid).setData(from: user)
            try saveSettings()
        } catch {
            print(error)
            self.error = Error()
        }
    }
    
    private func saveSettings() throws {
        let collection = FireStore.shared.firestore.collection(CollectionPath.Settings)
        try collection.document(uid).setData(from: settings)
    }
    
    struct Error: ErrorAlert {
        var title: String = "Save Error"
        var message: String = "There was a problem saving your changes on the server. Check your connection and try again"
    }
}
