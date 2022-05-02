//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import Firebase

@main
struct BlendateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
      FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .onOpenURL { url in
                    let link = url.absoluteString
                    let firebase = FirebaseManager.instance.auth
                    
                    if firebase.isSignIn(withEmailLink: link){
                        if let email = UserDefaults.standard.string(forKey: kEmailKey) {
                            firebase.signIn(withEmail: email, link: link)
                        }
                    }
                }
        }
    }
}
