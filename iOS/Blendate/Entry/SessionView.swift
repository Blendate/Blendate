//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct SessionView: View {
    @StateObject var session: UserViewModel
    @StateObject var swipe: SwipeViewModel
    @StateObject var notifcationManager = NotificationManager()

    @FirestoreQuery(collectionPath: "like_you") var likedYou: [Swipe]
    @FirestoreQuery(collectionPath: "superlike_you") var superLikedYou: [Swipe]
    
    private var allLikedUser: [Swipe] { likedYou + superLikedYou }
    private var uid: String { session.uid }
    
    var loading: Bool { session.state == .loading || swipe.loading }
    
    var body: some View {
        LoadingView(loading: loading, background: Color.Blue) {
            if session.state == .user {
                TabView(selection: $session.selectedTab) {
                    SwipeProfileView(superLikedYou: superLikedYou)
//                    CommunityView()
                    MatchesView(uid: uid, allLikes: allLikedUser)
                    PremiumView(likedYou: likedYou, superLikedYou: superLikedYou, today: nil)
                    ProfileView(user: $session.user, settings: $session.settings)
                }
                .environmentObject(session)
                .environmentObject(swipe)
                .onAppear(perform: setPredicates)
                .onChange(of: session.settings.notifications.isOn, perform: notificationChanged)
                .task {
                    await swipe.fetchLineup(for: session.user)
                    await requestPermission()
                }
            } else {
                SignupView(uid).environmentObject(session)
            }
        }
        .task {
            await session.fetch()
        }

    }
}
extension SessionView {
    
    private func requestPermission() async {
        let granted = await notifcationManager.requestPermission()
        notificationChanged(granted)
    }
    
    private func notificationChanged(_ isOn: Bool) {
        guard isOn else { session.set(fcm: ""); return }
        
        Task {
            if let fcm = await notifcationManager.getFCM() {
                session.set(fcm: fcm)
            }
        }
    }
    
    private func setPredicates() {
        print("📱 [SessioView] Setting LikedYou Predicates")
        $likedYou.path = CollectionPath.Path(swipeYou: .like, uid: uid)
        $superLikedYou.path = CollectionPath.Path(swipeYou: .superLike, uid: uid)
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





protocol TabItemView: View {
    static var TabItem:Tab {get}
}

extension SwipeProfileView { static let TabItem:Tab = .match }
extension CommunityView { static let TabItem:Tab = .community }
extension PremiumView { static let TabItem:Tab = .likes }
extension MatchesView { static let TabItem:Tab = .messages }
extension ProfileView { static let TabItem:Tab = .profile }
