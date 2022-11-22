//
//  NotificationService.swift
//  Blendate
//
//  Created by Michael on 11/18/22.
//

import Foundation

import UIKit
class PushNotificationSender {
    //"579356578076" ID
    private let SERVER_KEY: String = "AAAAhuRX0Rw:APA91bFUqtStnadEDxSxnJOWh9LJI1YAvDx1hXht5CA5km8hBWno_DjCeUHWkpkA0JaKZeCF1KlO1yvQJknw2stkWEgIyXpmLX8td_YBMLj5bIfrk-OE9LYIOswUItLqmNTDpokUiNms"
    private let BASE: URL = URL(string: "https://fcm.googleapis.com/fcm/notification")!
    
    
    func sendNotification(to fcm: String, from uid: String, title: String, body: String) async throws {
        var request = URLRequest(url: BASE)
        let notification: Notification = .init(to: fcm, notification: .init(title: title, body: body), data: .init(user: uid))
        request.httpMethod = "POST"
        request.httpBody = try JSONSerialization.data(withJSONObject:notification, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(SERVER_KEY)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { print(response);return }
        if let jsonDataDict  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
           print(jsonDataDict)
        }

    }
    
    struct Notification: Codable {
        let to: String
        let notification: Notif
        let data: NotifData
        
        struct NotifData: Codable {
            let user: String
        }
        
        struct Notif:Codable {
            let title: String
            let body: String
        }
    }
}
