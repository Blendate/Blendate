//
//  LikesView.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import SwiftUI

struct PremiumView: TabItemView {
    @EnvironmentObject var session: UserViewModel
    @EnvironmentObject var purchaseManager: PurchaseManager

    let likedYou: [Swipe]
    let superLikedYou: [Swipe]

    let today: User?
        
    @State var showMembership: Bool = false
    
    @State var showLikes = false
    
    var body: some View {
        Group {
            if showLikes {
                LikesView(likedYou: likedYou, superLikedYou: superLikedYou, showMembership: $showMembership, showLikes: $showLikes)
            } else {
                TodayView(todayUser: today, likedYou: likedYou, showMembership: $showMembership, showLikes: $showLikes)
            }
        }
        .tag( Self.TabItem )
        .tabItem{ Self.TabItem.image.environment(\.symbolVariants, .none) }
        .fullScreenCover(isPresented: $showMembership) {
            MembershipView()
        }
    }
}



struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView(likedYou: [], superLikedYou: [], today: nil)
    }
}
