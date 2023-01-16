//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 1/3/22.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var authState: FirebaseAuthState
    
    var body: some View {
        Group {
            switch authState.state {
            case .loading:
                LaunchView()
            case .noUser:
                WelcomeView()
            case .uid(let uid):
                SessionView(uid)
            }
        }
//        .onOpenURL(perform: firebaseSignin)

    }

}

//import FacebookCore
//extension EntryView {
//    private func firebaseSignin(with url: URL){
//        let link = url.absoluteString
//        print("🔗 [URL] \(link)")
//        FBSDKCoreKit.ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
//    }
//}


