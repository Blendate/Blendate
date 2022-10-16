//
//  AppDelegate.swift
//  Blendate
//
//  Created by Michael on 1/17/22.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging
//import FacebookCore

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase Setup
        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//        FBSDKCoreKit.ApplicationDelegate.shared.application(application,
//                         didFinishLaunchingWithOptions: launchOptions )
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

//    userInfo[gcmMessageIDKey]
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        if let fcm = fcmToken {
            UserDefaults.standard.set(fcm, forKey: "fcm")
        }
    }
}
