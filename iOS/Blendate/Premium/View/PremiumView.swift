//
//  LikesView.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct PremiumView: View {
    @EnvironmentObject var session: UserViewModel
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var purchaseManager: StoreManager

    @FirestoreQuery(collectionPath: "like_you") var likedYou: [Swipe]
    @FirestoreQuery(collectionPath: "superlike_you") var superLikedYou: [Swipe]


    var today: User?
    
    @State var showLikes = false
    
    var body: some View {
        Group {
            if purchaseManager.hasMembership {
                if showLikes {
                    LikesView(likedYou: likedYou, superLikedYou: superLikedYou, showLikes: $showLikes)
                } else {
                    TodayView(todayUser: today, likedYou: likedYou, showLikes: $showLikes)
                }
            } else {
                VStack {
                    MembershipView(showDismiss: false)
                    Spacer(minLength: 1)
                }
            }
        }
        .onAppear {
            $likedYou.path = CollectionPath.Path(swipeYou: .like, uid: session.uid)
            $superLikedYou.path = CollectionPath.Path(swipeYou: .superLike, uid: session.uid)
        }
    }
}



struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            PremiumView()
                .environmentObject(session)
                .environmentObject(StoreManager())
                .environmentObject(NavigationManager())
                .tabItem {
                    Label("Item", systemImage: "circle")
                }
        }

    }
}
