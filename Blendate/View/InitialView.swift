//
//  InitialView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import SwiftUI

enum InitialScreen {
    case welcome
    case onboarding
    case session
    case loading
}


struct EntryView : View {
    @EnvironmentObject var session: Session

    var body: some View {
        Group {
            switch session.currentView {
            case .onboarding:
                SignupView(user: $session.user)
            case .session:
                TabView(selection: $session.selectedTab) {
                    ProfileView($session.lineup)
                        .tabItem { Image("icon") }
                        .tag(1)
                    MessagesView($session.user)
                        .tabItem { Image("chat") }
                        .tag(2)
                    TodayBlendView(user: Dummy.user)
                        .tabItem { Image("heart") }
                        .tag(3)
                    ProfileView($session.user)
                        .tabItem { Image("profile") }
                        .tag(4)
                }
            case .loading:
                ZStack {
                    Color.LightBlue.edgesIgnoringSafeArea(.all)
                    Button("LOGOUT") {
                        session.logout()
                    }
                }
            case .welcome:
                WelcomeView()
            }
        }.onAppear {
            session.listenAuthenticationState()
        }
    }
}
