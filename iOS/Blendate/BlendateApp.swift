//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

@main
struct BlendateApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject var authState = FirebaseAuthState()
    var body: some Scene {
        WindowGroup {
            MockUsers()
//            EntryView()
//                .environmentObject(authState)
        }
    }
}

