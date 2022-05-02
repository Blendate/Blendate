//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseAuth

@main
struct BlendateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            EntryView()
                .onOpenURL { (url) in
                    let link = url.absoluteString
                    printD(link)
                    if Auth.auth().isSignIn(withEmailLink: link){
                        if let email = UserDefaults.standard.string(forKey: "Email") {
                            Auth.auth().signIn(withEmail: email, link: link)
                        }
                    }
                }
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}


extension UIApplication {
    

    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
extension UIApplication {
    

}
