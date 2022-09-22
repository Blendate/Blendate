//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import Firebase
import UIKit
import FacebookCore

@main
struct BlendateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .onAppear(
                    perform: UIApplication.shared.addTapGestureRecognizer
                )
                .onOpenURL { url in
                    firebaseSignin(with: url)
                }
        }
    }
    
    private func firebaseSignin(with url: URL){
        let link = url.absoluteString
        printD(link)
        let firebase = FirebaseManager.instance.auth
        
        if firebase.isSignIn(withEmailLink: link){
            if let email = UserDefaults.standard.string(forKey: kEmailKey) {
                firebase.signIn(withEmail: email, link: link)
            }
        } else {
            FBSDKCoreKit.ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: UIApplication.OpenURLOptionsKey.annotation)
        }
    }
}

