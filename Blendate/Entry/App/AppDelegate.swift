//
//  AppDelegate.swift
//  Blendate
//
//  Created by Michael on 1/17/22.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self
//
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
                       -> Void) {
      if let messageID = userInfo[gcmMessageIDKey] { print("Message ID: \(messageID)") }

      completionHandler(UIBackgroundFetchResult.newData)
    }
}


extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = fcmToken {
            UserDefaults.standard.set(fcm, forKey: "fcm")
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
      
    print(userInfo)
      
    completionHandler()
  }
}
