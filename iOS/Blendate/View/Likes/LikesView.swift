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
    @EnvironmentObject var match: MatchViewModel
    var likes: [String] = []
    @State var showLikes = false
    
    var activeMembership: Bool {
        session.user.premium.active
    }
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        if let first = match.lineup.last, !showLikes {
            TodayView(todayUser: first, showLikes: $showLikes)
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if match.lineup.count > 6 {
                        let array = Array(match.lineup.prefix(upTo: 6))
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

                        }
                    }
                    
                }
                .padding(.horizontal)
            }
        }

    }
}

struct LikesView_Previews: PreviewProvider {
    static var previews: some View {
        LikesView(likes: ["1234"])
        LikesView()

    }
}
