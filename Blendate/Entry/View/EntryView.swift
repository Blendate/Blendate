//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 1/3/22.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var loadingState: FirebaseAuthState
    
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


@MainActor
class FirebaseAuthState: ObservableObject {
    
    enum FirebaseState {
        case loading, noUser, uid(String)
    }

    @Published var state:FirebaseState = .loading
        
    init(){
        FirebaseManager.instance.auth.addStateDidChangeListener { (auth,user) in
            if let uid = user?.uid {
                self.state = .uid(uid)
            } else {
                self.state = .noUser
            }
        }
    }

}
