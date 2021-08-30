//
//  InitialView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import SwiftUI
import RealmSwift
enum InitialScreen {
    case welcome
    case onboarding
    case session
    case loading
}

//
//struct InitialView: View {
//    @EnvironmentObject var state: AppState
//
//    var body: some View {
//        if state.user != nil {
//            if state.currentView == .session {
//                MyTabView(selectedTab: $state.selectedTab, userID: state.user?.id ?? "", user: User())
//
//            } else {
//                SignupView()
//                    .environment(\.realmConfiguration, app.currentUser!.configuration(partitionValue: "user=\(state.user?._id ?? "")"))
//            }
//
//        } else {
//            WelcomeView()
//        }
//    }
//}

struct MyTabView: View {
    
    @Binding var selectedTab: Int
//    let userID: String
    @ObservedRealmObject var user: User

    var body: some View {
        TabView(selection: $selectedTab) {
            ProfileView(.dateProfile, user)
                .tabItem {
                    Image("icon-2")
//                        .foregroundColor(selectedTab == 0 ? .DarkPink:.Blue)
//                        .padding(10)
//                        .padding(.horizontal)
//                        .background(selectedTab == 0 ? Color.LightPink:Color.clear)
//                        .clipShape(Capsule())
                }
                .tag(1)
                .environment(\.realmConfiguration, MatchUserConfig())
            ChatRoomView()
                .tabItem {
                    Image("chat")
                }
                .tag(2)
                .environment(\.realmConfiguration, UserConfig())
            TodayBlendView()
                .tabItem { Image("heart") }
                .tag(3)
                .environment(\.realmConfiguration, MatchUserConfig())
            ProfileView(.myProfile, user)
                .tabItem { Image("profile") }
                .tag(4)
                .environment(\.realmConfiguration, UserConfig())
        }
    }
}


//struct InitialView_Previews: PreviewProvider {
//    static var previews: some View {
//        InitialView()
//            .environmentObject(AppState())
//    }
//}
//
