//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct SessionView: View {
    @StateObject var session: SessionViewModel
    @StateObject var matchVM: MatchViewModel
    @StateObject var premium: PremiumViewModel

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
        self._matchVM = StateObject(wrappedValue: MatchViewModel(uid))
        self._premium = StateObject(wrappedValue: PremiumViewModel(uid))
    }
    
    var body: some View {
        LoadingView(showLoading: matchVM.loading == true) {
            switch session.loadingState {
            case .user:
                tabView
            case .noUser:
                NavigationView {
                    PropertyView(.name, signup: true)
                }
            case .loading:
                Text("Loading")
            }
        }
        .environmentObject(session)
        .task {
            await premium.login(uid: session.uid)
            await session.fetchFirebase()
        }
    }
    
    var tabView: some View {
        TabView(selection: $session.selectedTab) {
            MatchProfileView()
                .tag(Tab.match)
                .tabItem{ Tab.match.image }
            LikesView()
                .tag(Tab.likes)
                .tabItem{Tab.likes.image}
            MessagesView(uid: session.uid)
                .tag(Tab.messages)
                .tabItem{ Tab.messages.image }
            CommunityView()
                .tag(Tab.community)
                .tabItem{Tab.community.image}
            ProfileView(user: $session.user)
                .tag(Tab.profile)
                .tabItem{ Tab.profile.image }
        }
        .environmentObject(premium)
        .environmentObject(matchVM)
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
