//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import Firebase
import FirebaseAnalytics
import FacebookCore
import RevenueCat

@main
struct BlendateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var authState = FirebaseAuthState()
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .environmentObject(authState)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer )
        }
    }
}


// MARK: - AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    private let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Purchases.logLevel = .info
        RevenueCatService.configure(withAPIKey: Secrets.revenueCat)
        RevenueCatService.setFirebaseAppInstanceId( Analytics.appInstanceID() )
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        Analytics.setAnalyticsCollectionEnabled(false)

        
        config_notifications(application)

        #warning("reactivate")
//        FBSDKCoreKit.ApplicationDelegate.shared
//            .application(application,
//                         didFinishLaunchingWithOptions: launchOptions )
        

        return true
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        let messageID = userInfo[gcmMessageIDKey]

        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    private func config_notifications(_ application: UIApplication){
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current()
            .requestAuthorization(
              options: authOptions,
              completionHandler: {_, _ in }
            )
        application.registerForRemoteNotifications()
    }
}

// MARK: - Firebase Messaging
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else {return}
        let oldFCM = UserDefaults.standard.string(forKey: String.kFCMstring)
        
        if oldFCM != fcmToken {
            UserDefaults.standard.set(fcmToken, forKey: String.kFCMstring)
        }
    }
}

// MARK: - Firebase Notifications
extension AppDelegate : UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          
        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        print(userInfo)

        completionHandler([[.banner, .badge, .sound]])
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

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }
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
