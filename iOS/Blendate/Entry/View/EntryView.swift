//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 1/3/22.
//

import SwiftUI

struct EntryView: View {
    
    @StateObject var loadingState = FirebaseAuthState()
    
    var body: some View {
        switch loadingState.state {
        case .loading:
            LaunchView()
        case .noUser:
            WelcomeView()
        case .uid(let uid):
            SessionView(uid)
        }
    }
}


import FirebaseAuth
@MainActor
class FirebaseAuthState: ObservableObject {
    
    enum FirebaseState {
        case loading, noUser, uid(String)
    }
    
    @Published var firUser: FirebaseAuth.User?
    @Published var state:FirebaseState = .loading
    
    init(){
        Auth.auth().addStateDidChangeListener { (auth,user) in
            print("Auth Changed: \(user?.uid ?? "No User")")
            self.firUser = user
            if let uid = user?.uid {
                self.state = .uid(uid)
            } else {
                self.state = .noUser
            }
        }
    }
}
