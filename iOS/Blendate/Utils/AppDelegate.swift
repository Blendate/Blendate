//
//  AppDelegate.swift
//  Blendate
//
//  Created by Michael on 1/17/22.
//

import SwiftUI
import Firebase
import FacebookCore
import RevenueCat

class AppDelegate: NSObject, UIApplicationDelegate {
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        config()
        config_notifications()
        application.registerForRemoteNotifications()

        FBSDKCoreKit.ApplicationDelegate.shared
            .application(application,
                         didFinishLaunchingWithOptions: launchOptions )
        

        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

      if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
      }

      print(userInfo)

      completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate {
    private func config() {
        RevenueCatService.configure(withAPIKey: Secrets.revenueCat)
//        RevenueCatService.setFirebaseAppInstanceId(RevenueCat.Analytics.appInstanceID())
        FirebaseApp.configure()
    }
    
    private func config_notifications(){
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: {_, _ in })


    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else {return}
        let oldFCM = UserDefaults.standard.string(forKey: String.kFCMstring)
        
        if oldFCM != fcmToken {
            UserDefaults.standard.set(fcmToken, forKey: String.kFCMstring)
        }
    }
}

extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
        print("Message ID: \(messageID)")
    }

    print(userInfo)

    // Change this to your preferred presentation option
    completionHandler([[.banner, .badge, .sound]])
  }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID from userNotificationCenter didReceive: \(messageID)")
    }

    print(userInfo)

    completionHandler()
  }
}
extension String {
    static public var kFCMstring: String { "fcm" }
}

//class AppDelegate: NSObject, UIApplicationDelegate {
//    let gcmMessageIDKey = "gcm.message_id"
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//        // Firebase Setup
//        FirebaseApp.configure()
//        Messaging.messaging().delegate = self
//
//        // FaceBook Init
//        FBSDKCoreKit.ApplicationDelegate.shared
//            .application(application,
//                         didFinishLaunchingWithOptions: launchOptions )
//        // Notification Delegate
//        UNUserNotificationCenter.current().delegate = self
////        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
////        UNUserNotificationCenter.current().requestAuthorization(
////          options: authOptions,
////          completionHandler: {_, _ in })
//        application.registerForRemoteNotifications()
//        return true
//    }
//
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//
//
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        print("[NOTIFICATION] Remote Notification")
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//          print("Message ID: \(messageID)")
//        }
//
//        print(userInfo)
//        completionHandler(UIBackgroundFetchResult.newData)
//    }
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//    let userInfo = response.notification.request.content.userInfo
//    print("[NOTIFICATION] Did Receive Notification")
//    print(userInfo)
//
//
//    completionHandler()
//  }
//}
//
//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//
//        if let fcm = fcmToken {
//            print("[FCM] \(fcm)")
//            UserDefaults.standard.set(fcm, forKey: "fcm")
//        }
//    }
//}
