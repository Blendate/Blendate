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

    @StateObject var notification = NotificationModel()
    init() {
//      FirebaseApp.configure()
        
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                .onOpenURL { url in
                    printD(url.absoluteString)
                    firebaseSignin(with: url)
                }
        }
    }
    
    func firebaseSignin(with url: URL){
        let link = url.absoluteString
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

class NotificationModel: NSObject, ObservableObject, UNUserNotificationCenterDelegate, MessagingDelegate {
        func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
            if let fcm = fcmToken {
                printD(fcm)
                UserDefaults.standard.set(fcm, forKey: "fcm")
            }
        }
    
    
        func userNotificationCenter(_ center: UNUserNotificationCenter,
                                  didReceive response: UNNotificationResponse,
                                  withCompletionHandler completionHandler: @escaping () -> Void) {
            let userInfo = response.notification.request.content.userInfo

            print(userInfo)

            completionHandler()
        }
}
