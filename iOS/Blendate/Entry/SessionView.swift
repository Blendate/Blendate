//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct SessionView: View {
    @EnvironmentObject var navigation: NavigationManager
    @StateObject var notifcationManager = NotificationManager()

    @StateObject var model: UserViewModel

    
    var body: some View {
        TabView(selection: $navigation.selectedTab) {
            SwipeProfileView(model: .init(model.uid) )
            MatchesView(uid: model.uid)
            PremiumView()
            ProfileView()
                
        }
        .fullScreenCover(isPresented: $navigation.showPurchaseMembership) { MembershipView() }
        .sheet(isPresented: $navigation.showPurchaseLikes) { PurchaseLikesView(settings: $model.settings) }
        .environmentObject(model)

//        .onChange(of: session.settings.notifications.isOn, perform: notificationChanged)
    }
}
extension SessionView {
    
//    private func requestPermission() async {
//        let granted = await notifcationManager.requestPermission()
//        notificationChanged(granted)
//    }
    
//    private func notificationChanged(_ isOn: Bool) {
//        guard isOn else { session.set(fcm: ""); return }
//
//        Task {
//            if let fcm = await notifcationManager.getFCM() {
//                session.set(fcm: fcm)
//            }
//        }
//    }
    
//    private func setPredicates() {
//        print("📱 [SessioView] Setting LikedYou Predicates")
//        $likedYou.path = CollectionPath.Path(swipeYou: .like, uid: session.uid)
//        $superLikedYou.path = CollectionPath.Path(swipeYou: .superLike, uid: session.uid)
//    }
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
