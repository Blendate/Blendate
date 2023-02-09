//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct SessionView: View {
    @StateObject var session: SessionViewModel
    @StateObject var match: SwipeViewModel

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
        self._match = StateObject(wrappedValue: SwipeViewModel(uid))
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
            await session.fetchFirebase()
            await session.login()
            await match.fetchLineup()
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
        .environmentObject(match)
        .fullScreenCover(isPresented: $session.showMembership) {
            MembershipView()
                .environmentObject(session)
        }
        .sheet(isPresented: $session.showSuperLike) {
            PurchaseLikesView()
                .presentationDetents([.medium])
                .environmentObject(session)
        }
        .task {
            await session.checkNotification()
        }
    }
}
enum Tab: String, CaseIterable, Identifiable {
    var id: String {self.rawValue }
    case match, likes, messages, community, profile

    var image: Image {
        switch self {

        case .match:
            return Image("icon-2")
        case .likes:
            return Image(systemName: "star")
        case .messages:
            return Image("chat")
        case .community:
            return Image(systemName: "person.3")
        case .profile:
            return Image("profile")
        }
    }
}
