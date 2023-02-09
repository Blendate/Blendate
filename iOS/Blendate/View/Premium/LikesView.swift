//
//  LikesView.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import SwiftUI
import CachedAsyncImage

struct PremiumView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @EnvironmentObject var swipe: SwipeViewModel

    @State var likedyou: [User] = []
    @State var showLikes = false
    
    var body: some View {
        if showLikes {
            if !likedyou.isEmpty {
                Likes(likedYou: $likedyou, showLikes: $showLikes)
            } else {
                VStack {
                    EmptyLineupView(text: "There are no Likes just set, try and open your filters so other users can see you")
                    Button("Today's Blend"){
                        showLikes = false
                    }
                    .foregroundColor(.white)
                    .capsuleButton(color: .DarkPink, fontsize: 18)
                    .padding(.bottom)
                }
            }
        } else {
            if let last = swipe.lineup.last {
                TodayView(todayUser: last, showLikes: $showLikes)
            } else {
                VStack {
                    EmptyLineupView(text: "There are no special Blends left today. Check again tomorrow for a new profile")
                    Button("View Likes"){
                        showLikes = false
                    }
                    .foregroundColor(.white)
                    .capsuleButton(color: .DarkPink, fontsize: 18)
                    .padding(.bottom)
                }
            }
        }

        
    }
}

extension PremiumView {
    struct Likes: View {
        @EnvironmentObject var settings: SettingsViewModel
        @Binding var likedYou: [User]
        @Binding var showLikes: Bool
        
        @State var chosenUser: User?

        private let columns = [GridItem(.flexible()), GridItem(.flexible())]

        var body: some View {
            ZStack(alignment: .bottom) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        if likedYou.count > 6 {
                            let array = Array(likedYou.prefix(upTo: 6))
                            ForEach(array) { user in
                                VStack {
                                    if let url = user.avatar {
                                        CachedAsyncImage(urlRequest: URLRequest(url: url), urlCache: .imageCache) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                            //                                        .frame(width: size.width, height: size.height, alignment: .center)
                                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                                .blur(radius: settings.hasPremium  ? 0 : 20)
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    }
                                    Text(user.firstname)
                                        .foregroundColor(.white)
                                        .blur(radius: settings.hasPremium  ? 0 : 20)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                                            .frame(height: 300)
                                .background(user.color)
                                .cornerRadius(16)
                                .onTapGesture {
                                    if settings.hasPremium  {
                                        self.chosenUser = user
                                    } else {
                                        settings.showMembership = true
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
                SwipeProfileView(user: user)
            }
        }
    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        PremiumView(likedyou: [dev.michael, dev.tyler])
            .environmentObject(SettingsViewModel(dev.michael.id!))
    }
}
