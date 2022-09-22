//
//  AppDelegate.swift
//  Blendate
//
//  Created by Michael on 1/17/22.
//

import SwiftUI
import Firebase
import FacebookCore

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase Setup
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        FBSDKCoreKit.ApplicationDelegate.shared
            .application(application,
                         didFinishLaunchingWithOptions: launchOptions )
        UNUserNotificationCenter.current().delegate = self
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//      if let messageID = userInfo[gcmMessageIDKey] {
//          print("Message ID: \(messageID)")
//      }
      completionHandler(UIBackgroundFetchResult.newData)
    }
    
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      
//    let userInfo = response.notification.request.content.userInfo
      
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
