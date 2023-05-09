////
////  SessionViewModel.swift
////  Blendate
////
////  Created by Michael on 4/1/22.
////
//
//import SwiftUI
//
//enum SessionState {case loading, onboarding, user}
//
//class FUserF: ObservableObject {
//    
//}
//
//class UserViewModel: ObservableObject {
//    @Published var state = SessionState.loading
//    
//    @Published var user = User()
//    @Published var settings = User.Settings()
//        
//    let uid: String
//    private let firestore = FireStore.instance
//    
//    init(_ uid: String){ self.uid = uid }
//    
//    @MainActor
//    func fetch() async {
//        do {
//            self.user = try await firestore.fetch(fid: uid)
//            self.settings = try await firestore.fetch(fid: uid)
//            print("Fetched \(self.user.id ?? "NO ID")")
//            withAnimation { self.state = .user }
//        } catch {
//            print(error.localizedDescription)
//            withAnimation { self.state = .onboarding }
//        }
//    }
//    
//    @MainActor
//    func createDoc() throws {
//        let _ = try firestore.create(user, fid: uid)
//        let _ = try firestore.create(settings, fid: uid)
//        user.id = uid
//        settings.id = uid
//        state = .user
//    }
//    
//    @MainActor
//    func set(fcm: String) {
//        print("Setting FCM: \(fcm.prefix(8))")
//        settings.notifications.fcm = fcm
//        do {
//            try saveSettings()
//        } catch {
//            print(error)
//        }
//    }
//
//    
//    func saveSettings() throws {
//        try firestore.update(settings)
//    }
//    
//    func saveUser() throws {
//        try firestore.update(user)
//    }
//}
//
//
//
