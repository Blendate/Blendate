//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 1/3/22.
//

import SwiftUI
import FirebaseAuth

struct EntryView: View {
    @EnvironmentObject var authState: FirebaseAuthState
    
    var body: some View {
        Group {
            switch authState.state {
            case .loading:
                LaunchView()
            case .noUser:
                WelcomeView()
            case .uid(let uid):
                SessionView(uid: uid)
            }
        }
    }
}

struct LaunchView<Background:View>: View {
    let background: Background
    init(background: Background = Color.Blue) { self.background = background }
    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            Image.Icon(.white)
        }
    }
}

