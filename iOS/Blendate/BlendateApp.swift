//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import Firebase

import FacebookCore
import Foundation

@main
struct BlendateApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var authState = FirebaseAuthState()
    @StateObject private var purchaseManager: PurchaseManager
    @StateObject private var entitlementManager: EntitlementManager

    init(){
        FirebaseApp.configure()

        let entitlementManager = EntitlementManager()
        let purchaseManger = PurchaseManager(entitlementManager: entitlementManager)
        
        self._entitlementManager = StateObject(wrappedValue: entitlementManager)
        self._purchaseManager = StateObject(wrappedValue: purchaseManger)
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .environmentObject(authState)
                .environmentObject(purchaseManager)
                .environmentObject(entitlementManager)
                .task {
                    await purchaseManager.updatePurchasedProducts()
                    await purchaseManager.fetchProducts()
                }
                .onAppear {
                    FBSDKCoreKit.ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
                    UIApplication.shared.addTapGestureRecognizer()
                }
        }
    }
}



import FirebaseAnalytics
import FirebaseAuth
import FirebaseStorage
extension BlendateApp {
    func firebaseConfig(){
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        Analytics.setAnalyticsCollectionEnabled(false)
#if EMULATORS
        print(
        """
        *********************
        Testing on Emulator
        *********************
        """
        )
        Auth.auth().useEmulator(withHost: "localhost", port: 4000)
        Storage.storage().useEmulator(withHost: "localhost", port: 4000)
        let settings = Firestore.firestore().settings
        settings.host = "localhost:4000"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
#elseif DEBUG
        print(
        """
        *********************
        Testing on Live
        *********************
        """
        )
#endif
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
