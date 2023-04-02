//
//  LikesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/14/23.
//

import SwiftUI

struct LikesView: View {
    @EnvironmentObject var session: UserViewModel
    
    let likedYou: [Swipe]
    let superLikedYou: [Swipe]
    
    @Binding var showMembership: Bool
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
                                Cell(uid: uid, chosen: $chosenUser, showMembership: $showMembership)
                            }
                            
                        }
                    }
                }
                Button("Today's Blend"){
                    showLikes = false
                }
                .foregroundColor(.white)
                .shapeButton(shape: .roundedRectangle, color: .Blue)
                .padding(.bottom)
            }
            .background(text: "", bottom: false)
            .sheet(item: $chosenUser) { user in
                SwipeProfileView(user: user, superLikedYou: superLikedYou)
            }
        } else {
            EmptyLineupView(loading: .constant(false),
                            svg: "Interested",
                            text: "When someone likes you they will show up here, keep Bleding and check back here to see other's that have liked you") {
                FilterButton(user: $session.user, settings: $session.settings)
            } button2: {
                Button("Today's Blend"){ showLikes = false }
                    .shapeButton(shape: .roundedRectangle, color: .Purple)
            }
            
        }
    }
}

extension LikesView {
    struct Cell: View {
        @EnvironmentObject var entitlement: EntitlementManager
        
        let uid: String
        var hasPremium: Bool { entitlement.hasPro }
        @State var user: User? = nil
        @Binding var chosen: User?
        @Binding var showMembership: Bool
        
        var body: some View {
            Group {
                VStack {
                    AsyncImage(url: user?.details.avatar ) { image in
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
                    Text(user?.details.firstname ?? " ")
                        .foregroundColor(.white)
                        .blur(radius: hasPremium  ? 0 : 20)
                }
                .onTapGesture {
                    if hasPremium  {
                        self.chosen = user
                    } else {
                        showMembership = true
                    }
                }

            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .cornerRadius(16)
            .task {
                guard user == nil else {return}
                self.user = try? await FireStore.instance.fetch(fid:uid)
            }
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView(likedYou: [], superLikedYou: [], showMembership: .constant(false), showLikes: .constant(true))

    }
}
