//
//  NotificationManager.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/4/23.
//

import SwiftUI
import Firebase

class NotificationManager: NSObject, ObservableObject {
    
    let notificationCenter = UNUserNotificationCenter.current()


    override init(){
        super.init()
        Messaging.messaging().delegate = self
        
    }
    
    func requestPermission() async -> Bool {
        do {
            let authorized = try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
            return authorized
        } catch {
            print(error)
            return false
        }
    }
    
    func getFCM() async -> String? {
        let status: UNAuthorizationStatus = await notificationCenter.notificationSettings().authorizationStatus
        
        switch status {
            
        case .notDetermined:
            let granted = await requestPermission()
            if granted {
                return try? defaultsFCM()
            } else {return nil}
        case .authorized, .provisional, .ephemeral:
            return try? defaultsFCM()
        case .denied:
            return nil
        @unknown default: return nil
            
        }

    }
    
    private func defaultsFCM() throws -> String {
        if let fcm = UserDefaults.standard.string(forKey: String.kFCMstring) {
            return fcm
        } else {
            throw Error()
        }
    }
}

extension NotificationManager {
    struct Error:Swift.Error {
        var localizedDescription: String = "There was an error setting notification's on the server"
    }
}
extension NotificationManager:MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let token = fcmToken else {return}
        print("Got FCM: \(token.prefix(10))")
        UserDefaults.standard.set(token, forKey: String.kFCMstring)
    }
}
