//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 1/3/22.
//

import SwiftUI
import FirebaseAuth

struct EntryView: View {
    @EnvironmentObject var storeManager: StoreManager
    @EnvironmentObject var navigation: NavigationManager

    var body: some View {
        Group {
            switch navigation.state {
            case .loading:
                LaunchView()
            case .noUser:
                WelcomeView()
            case .onboarding(let uid):
                SignupView(model: .init(uid: uid))
            case .user(let uid, let user):
                SessionView(model: .init(uid: uid, user: user))
            }
        }
        .task {
            await storeManager.updatePurchasedProducts()
            await storeManager.fetchProducts()
        }
    }
}

struct LaunchView<Background:View>: View {
    let background: Background
    var body: some View {
        ZStack {
            background
            Image.Icon(.white)
        }
        .ignoresSafeArea()
    }
    
    init(background: Background = Color.Blue) { self.background = background }
}

