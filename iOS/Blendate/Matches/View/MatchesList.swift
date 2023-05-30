//
//  MatchesList.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/11/23.
//

import SwiftUI

struct MatchesList: View {
    
    let uid: String
    let matches: [Match]
    let likedYou: [Swipe]

    var body: some View {
        VStack {
            if !matches.isEmpty {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing: 15){
                        LikeYou(likedYou: likedYou)
                        ForEach(matches){
                            MatchCell(match: $0, author: uid)
                        }
                    }
                    .padding(.leading)
                }
            }
            else {
                HStack(alignment: .center) {
                    LikeYou(likedYou: likedYou)
                    Text("Match with profiles to Blend with others")
                        .font(.body.weight(.semibold), .DarkBlue)
                    Spacer()
                }
                .padding(.leading)
            }
        }
        .padding(.vertical)
    }
}

extension MatchesList {
    struct LikeYou: View {
        @EnvironmentObject var navigation: NavigationManager
        @EnvironmentObject var entitlement: StoreManager
//        @EnvironmentObject var session: UserViewModel
        var likedYou: [Swipe]
        
        @State var firstUser: User?
        
        var hasPremium: Bool { entitlement.hasMembership }
        
                
        var body: some View {
            Button {
                if hasPremium {
                    navigation.selectedTab = .likes
                } else {
                    navigation.showPurchaseMembership = true
                }
            } label: {
                ZStack {
                    VStack {
                        ZStack{
                            Circle()
                                .stroke(  Color.DarkBlue, lineWidth: 2)
                                .frame(width: 80, height: 80, alignment: .center)
                            PhotoView(avatar: firstUser?.avatar)
                                .blur(radius: hasPremium ? 0 : 20)
                                .clipShape(Circle())
                        }
                    }
                    VStack(spacing: 0) {
                        Text(likedYou.count.description)
                        Text(likedYou.count == 1 ? "Like" : "Likes")
                    }
                    .font(.semibold, .white)
                }
            }
            .task {
                guard firstUser == nil, let uid = likedYou.first?.id else {return}
                self.firstUser = try? await FireStore.shared.fetch(uid: uid)
            }
        }
    }
}


struct MatchesList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchesList(uid: aliceUID, matches: [match], likedYou: likedUser)
                .previewDisplayName("Match+Likes")
            MatchesList(uid: aliceUID, matches: [match], likedYou: [])
                .previewDisplayName("Match")
            MatchesList(uid: aliceUID, matches: [], likedYou: [Swipe(.like)])
                .previewDisplayName("Likes")
            MatchesList(uid: aliceUID, matches: [], likedYou: [])
                .previewDisplayName("Empty")

        }
        .previewLayout(.sizeThatFits)
        .environmentObject(StoreManager())
        .environmentObject(session)
//        .environmentObject(session)
    }
}
