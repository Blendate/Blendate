//
//  LikesView.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import SwiftUI
import CachedAsyncImage

struct LikesView: View {
    @EnvironmentObject var session: SessionViewModel
//    @EnvironmentObject var match: MatchViewModel
    @State var likedyou: [User] = []

    var likes: [String] = []
    @State var showLikes = false
    @State var chosenUser: User?
    
    var activeMembership: Bool {
        session.hasPremium
    }
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        if let first = likedyou.last, !showLikes {
            TodayView(todayUser: first, showLikes: $showLikes)
        } else {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        if likedyou.count > 6 {
                            let array = Array(likedyou.prefix(upTo: 6))
                            ForEach(array) { user in
                                VStack {
                                    if let url = user.avatar {
                                        CachedAsyncImage(urlRequest: URLRequest(url: url), urlCache: .imageCache) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                            //                                        .frame(width: size.width, height: size.height, alignment: .center)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .blur(radius: activeMembership ? 0 : 20)
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    Text(user.firstname)
                                        .foregroundColor(.white)
                                        .blur(radius: activeMembership ? 0 : 20)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                //                            .frame(height: 300)
                                .background(user.color)
                                .cornerRadius(16)
                                .onTapGesture {
                                    if activeMembership {
                                        self.chosenUser = user
                                    } else {
                                        session.showMembership = true
                                    }
                                }
                                
                            }
                        }
                    }
                }
                Button("Today's Blend"){
                    showLikes = false
                }
                .foregroundColor(.white)
                .capsuleButton(color: .Blue, fontsize: 18)
                .padding(.bottom)
            }
            .sheet(item: $chosenUser) { user in
                MatchProfileView(user: user)
            }

        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView(likes: ["1234"])
            .environmentObject(SessionViewModel(dev.michael.id!))
            .environmentObject(SwipeViewModel(dev.michael.id!))
//        LikesView()

    }
}
