//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct SessionView: View {
    @StateObject var session: SessionViewModel
    @StateObject var swipe: SwipeViewModel
    @StateObject var match: MatchesViewModel
    @StateObject var settings: SettingsViewModel

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
        self._swipe = StateObject(wrappedValue: SwipeViewModel(uid))
        self._match = StateObject(wrappedValue: MatchesViewModel(uid))
        self._settings = StateObject(wrappedValue: SettingsViewModel(uid))
    }
    
    var body: some View {
        Group {
            if session.state == .noUser {
                NavigationView {
                    PropertyView(detail: .name, signup: true)
                }
            } else {
                LoadingView(showLoading: swipe.loading == true) {
                    TabView(selection: $session.selectedTab) {
                        SwipeProfileView()
                            .tag(Tab.match).tabItem{ Tab.match.image }
                        CommunityView()
                            .tag(Tab.community).tabItem{Tab.community.image.environment(\.symbolVariants, .none)}
                        PremiumView()
                            .tag(Tab.likes).tabItem{Tab.likes.image.environment(\.symbolVariants, .none)}
                        MatchesView()
                            .tag(Tab.messages).tabItem{ Tab.messages.image }
                        ProfileView(user: $session.user)
                            .tag(Tab.profile).tabItem{ Tab.profile.image }
                    }
                }
                .environmentObject(settings)
                .environmentObject(match)
                .environmentObject(swipe)
                .task {
                    await swipe.fetchLineup()
                    await settings.login()
                    await settings.checkNotification()

                }
            }
        }
        .environmentObject(session)
        .task {
            await session.fetchFirebase()
        }
        .fullScreenCover(isPresented: $settings.showMembership) {
            MembershipView().environmentObject(settings)
        }
        .sheet(isPresented: $settings.showSuperLike) {
            PurchaseLikesView()
                .environmentObject(settings)
                .presentationDetents([.medium])
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
