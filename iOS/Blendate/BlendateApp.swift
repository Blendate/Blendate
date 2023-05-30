//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import Firebase
//import FacebookCore
import Foundation

@main
struct BlendateApp: App {
    @StateObject var storeManager = StoreManager()
    @StateObject var navigation = NavigationManager.shared

    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
            .environmentObject(navigation)
            .environmentObject(storeManager)
            .onAppear {
//                FBSDKCoreKit.ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                UIApplication.shared.addTapGestureRecognizer()
            }
        }
    }
}


//// MARK: - AppDelegate
//class AppDelegate: NSObject, UIApplicationDelegate {
//    private let gcmMessageIDKey = "gcm.message_id"
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
////        Purchases.logLevel = .info
////        RevenueCatService.configure(withAPIKey: Secrets.revenueCat)
////        RevenueCatService.setFirebaseAppInstanceId( Analytics.appInstanceID() )
//        FirebaseApp.configure()
////        firebaseConfig()
//
//
//        config_notifications(application)
//
////        FBSDKCoreKit.ApplicationDelegate.shared
////            .application(application,
////                         didFinishLaunchingWithOptions: launchOptions )
//
//
//        return true
//    }
//
//
//    private func config_notifications(_ application: UIApplication){
//        Messaging.messaging().delegate = self
//        UNUserNotificationCenter.current().delegate = self
////        let authOptions: UNAuthorizationOptions =
////        UNUserNotificationCenter.current()
////            .requestAuthorization(
////              options: [.alert, .badge, .sound],
////              completionHandler: {_, _ in }
////            )
//        application.registerForRemoteNotifications()
//    }
//}

//
//// MARK: - Firebase Messaging
//extension AppDelegate: MessagingDelegate {
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("Firebase Messaging Received Token: \(fcmToken ?? "")")
//        if let fcmToken {
//            UserDefaults.standard.set(fcmToken, forKey: String.kFCMstring)
//        }
//    }
//}
//
//// MARK: - Firebase Notifications
//extension AppDelegate : UNUserNotificationCenterDelegate {
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//        let userInfo = notification.request.content.userInfo
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//        print(userInfo)
//
//        completionHandler([[.banner, .badge, .sound]])
//    }
//
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              didReceive response: UNNotificationResponse,
//                              withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//          print("Message ID from userNotificationCenter didReceive: \(messageID)")
//        }
//
//        print(userInfo)
//
//        completionHandler()
//    }
//
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//    }
//}
