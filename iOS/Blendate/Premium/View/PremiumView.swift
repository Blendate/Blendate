//
//  LikesView.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct PremiumView: TabItemView {
    @EnvironmentObject var session: UserViewModel
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var purchaseManager: StoreManager

    @FirestoreQuery(collectionPath: "like_you") var likedYou: [Swipe]
    @FirestoreQuery(collectionPath: "superlike_you") var superLikedYou: [Swipe]


    var today: User?
    
    @State var showLikes = false
    
    var body: some View {
        Group {
            if showLikes {
                LikesView(likedYou: likedYou, superLikedYou: superLikedYou, showLikes: $showLikes)
            } else {
                TodayView(todayUser: today, likedYou: likedYou, showLikes: $showLikes)
            }
        }
        .onAppear {
            $likedYou.path = CollectionPath.Path(swipeYou: .like, uid: session.uid)
            $superLikedYou.path = CollectionPath.Path(swipeYou: .superLike, uid: session.uid)
        }
        .tag( Self.TabItem )
        .tabItem{ Self.TabItem.image.environment(\.symbolVariants, .none) }
    }
}



struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView()
            .environmentObject(session)
            .environmentObject(StoreManager())
            .environmentObject(NavigationManager())
    }
}
