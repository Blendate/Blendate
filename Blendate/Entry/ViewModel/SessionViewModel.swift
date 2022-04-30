//
//  SessionViewModel.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import SwiftUI
import Firebase



//
//    func requestAuthorizationForNotifications() async {
//        do {
//            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
//            if granted != self.user.settings.notifications.isOn {
//                self.user.settings.notifications.isOn = granted
//                if let fcm = UserDefaults.standard.string(forKey: "fcm"),
//                   self.user.fcm.isEmpty {
//                    self.user.fcm = fcm
//                }
//                try UserService().updateUser(with: self.user)
//            }
//
//        } catch {
//            printD(error)
//        }
//    }
