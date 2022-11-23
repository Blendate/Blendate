//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 1/3/22.
//

import SwiftUI
import Firebase
import FacebookCore
import UIKit

struct EntryView: View {
    @EnvironmentObject var authState: FirebaseAuthState
    
    var body: some View {
        Group {
            switch authState.state {
            case .loading:
                LaunchView()
            case .noUser:
                WelcomeView2()
            case .uid(let uid):
                SessionView(uid)
            }
        }
        .onOpenURL(perform: firebaseSignin)
        .onAppear(
            perform: UIApplication.shared.addTapGestureRecognizer
        )

    }
    
    private func firebaseSignin(with url: URL){
        let link = url.absoluteString
        print("🔗 [URL] \(link)")
        FBSDKCoreKit.ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
    }
}


@MainActor
class FirebaseAuthState: ObservableObject {
    
    enum FirebaseState {
        case loading, noUser, uid(String)
    }
    
    @Published var auth: Auth = Auth.auth()
    @Published var firUser: FirebaseAuth.User?
    @Published var state:FirebaseState = .loading
    
    private let firebase = Firestore.firestore()
    
    init(){
        auth.addStateDidChangeListener { (auth,user) in
            print("🔥 [Auth] Changed: \(user?.uid ?? "No User")")
            self.firUser = user
            if let uid = user?.uid {
                self.state = .uid(uid)
            } else {
                self.state = .noUser
            }
        }
    }
    
    func signout(){
        try? auth.signOut()
    }
}
