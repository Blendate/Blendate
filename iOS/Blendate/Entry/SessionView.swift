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

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
        self._matchVM = StateObject(wrappedValue: MatchViewModel(uid))
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
        .environmentObject(matchVM)
        .task {
            await session.checkNotification()
        }
        .fullScreenCover(isPresented: $session.showMembership) {
            MembershipView(premium: $session.user.premium)
        }
        .sheet(isPresented: $session.showSuperLike) {
            PurchaseLikesView(premium: $session.user.premium)
                .presentationDetents([.medium])
        }
    }
}
