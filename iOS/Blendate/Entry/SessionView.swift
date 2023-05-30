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

    private var uid: String { model.uid }
    
    var body: some View {
        TabView(selection: $navigation.selectedTab) {
            SwipeProfileView(model: .init(uid) )
                .tag(Tab.match)
                .tabItem{Tab.match.image}
            
            PremiumView()
                .tag(Tab.likes)
                .tabItem{Tab.likes.image}
            
            MatchesView(uid: uid)
                .tag(Tab.messages)
                .tabItem{Tab.messages.image.environment(\.symbolVariants, .none) }
            
            ProfileView()
                .tag(Tab.profile)
                .tabItem{Tab.profile.image}
                
        }
        .fullScreenCover(isPresented: $navigation.showPurchaseMembership) {
            MembershipView()
        }
        .sheet(isPresented: $navigation.showPurchaseLikes) {
            PurchaseLikesView(settings: $model.settings)
        }
        .environmentObject(model)
    }
}





//        .onChange(of: session.settings.notifications.isOn, perform: notificationChanged)
//extension SessionView {
    
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
//}
