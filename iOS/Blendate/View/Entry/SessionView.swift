//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct SessionView: View {
    @StateObject var session: SessionViewModel
    @StateObject var match: MatchViewModel
    @StateObject var premium: SettingsViewModel

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
        self._match = StateObject(wrappedValue: MatchViewModel(uid))
        self._premium = StateObject(wrappedValue: SettingsViewModel(uid))
    }
    
    var body: some View {
        LoadingView(showLoading: match.loading == true) {
            switch session.loadingState {
            case .user:
                tabView
            case .noUser:
                NavigationView {
                    PropertyView(detail: .name, signup: true)
                }
            case .loading:
                Text("Loading")
            }
        }
        .environmentObject(session)
        .task {
            await premium.login(uid: session.uid)
            await session.fetchFirebase()
            await match.fetchLineup()
            await premium.fetchOfferings()
        }
    }
    
    var tabView: some View {
        TabView(selection: $session.selectedTab) {
            MatchProfileView()
                .tag(Tab.match)
                .tabItem{ Tab.match.image }
            CommunityView()
                .tag(Tab.community)
                .tabItem{
                    Tab.community.image
                        .environment(\.symbolVariants, .none)
                }
            LikesView()
                .tag(Tab.likes)
                .tabItem{
                    Tab.likes.image
                        .environment(\.symbolVariants, .none)
                }
            MessagesView(uid: session.uid)
                .tag(Tab.messages)
                .tabItem{ Tab.messages.image }
            ProfileView(user: $session.user)
                .tag(Tab.profile)
                .tabItem{ Tab.profile.image }
        }
        .environmentObject(premium)
        .environmentObject(match)
        .fullScreenCover(isPresented: $premium.showMembership) {
            MembershipView()
                .environmentObject(premium)
        }
        .sheet(isPresented: $premium.showSuperLike) {
            PurchaseLikesView()
                .presentationDetents([.medium])
                .environmentObject(premium)
        }
        .task {
            await premium.checkNotification()
        }
    }
}
