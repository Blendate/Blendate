//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import SwiftUI

@main
struct BlendateApp: App {
    @StateObject var state = AppState()

    var body: some Scene {
        WindowGroup {
//            InitialView()
            EntryView()
                .environmentObject(state)

        }
    }
}

/**
 if request.time < timestamp.date(2021, 4, 31)
 
 If not create profile right away Ask for images should be after profile creation
 
 
 big tile for about that can be scrollable
 
 */
