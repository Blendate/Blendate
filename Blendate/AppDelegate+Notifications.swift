//
//  AppDelegate+Notifications.swift
//  Blendate
//
//  Created by Michael on 3/21/22.
//

import Foundation
import Firebase

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
