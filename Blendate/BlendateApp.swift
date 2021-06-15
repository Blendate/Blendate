//
//  BlendateApp.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import SwiftUI
import Firebase

@main
struct BlendateApp: App {
    let session = Session()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            EntryView()
                .environmentObject(session)
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}

/**
 if request.time < timestamp.date(2021, 4, 31)
 
 If not create profile right away Ask for images should be after profile creation
 
 
 */
