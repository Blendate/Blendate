//
//  LikesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/14/23.
//

import SwiftUI

struct LikesView: View {
    
    let likedYou: [Swipe]
    let superLikedYou: [Swipe]
    
    @Binding var showLikes: Bool
    
    @State var chosenUser: User?
    
    var likes: [Swipe] { likedYou + superLikedYou }
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        if !likes.isEmpty {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(likes) { like in
                            if let uid = like.id {
                                Cell(uid: uid, chosen: $chosenUser)
                            }
                            
                        }
                    }
                }
                ProfileButtonLong(title: "Today's Blend", color: .Purple) { showLikes = false }
                    .padding(.horizontal, 32)
                    .padding(.bottom)
            }
            .background(text: "", bottom: false)
//            .sheet(item: $chosenUser) { user in
//                SwipeProfileView(user: user, superLikedYou: superLikedYou)
//            }
        } else {
            EmptyLineupView(loading: .constant(false),
                            svg: "Interested",
                            text: "When someone likes you they will show up here, keep Bleding and check back") {
            } button2: {
                ProfileButtonLong(title: "Today's Blend", color: .Purple) { showLikes = false }
                    .padding(.horizontal, 32)
            }
            
        }
    }
}

extension LikesView {
    struct Cell: View {
        @EnvironmentObject var entitlement: StoreManager
        @EnvironmentObject var navigation: NavigationManager

        let uid: String
        var hasPremium: Bool { entitlement.hasMembership }
        @State var user: User? = nil
        @Binding var chosen: User?
        
        var body: some View {
            Group {
                VStack {
                    AsyncImage(url: user?.avatar ) { image in
                        image
                            .resizable()
                            .scaledToFit()
                        //                                        .frame(width: size.width, height: size.height, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .blur(radius: hasPremium  ? 0 : 20)

                    } placeholder: {
                        Rectangle().fill(Color.Blue)
                            .frame(height: 100)
//                                            ProgressView()
                    }
                    Text(user?.firstname ?? " ")
                        .foregroundColor(.white)
                        .blur(radius: hasPremium  ? 0 : 20)
                }
                .onTapGesture {
                    if hasPremium  {
                        self.chosen = user
                    } else {
                        navigation.showPurchaseMembership = true
                    }
                }

            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .cornerRadius(16)
            .task {
                guard user == nil else {return}
                self.user = try? await FireStore.instance.fetch(uid: uid)
            }
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView(likedYou: [], superLikedYou: [], showLikes: .constant(true))

    }
}
