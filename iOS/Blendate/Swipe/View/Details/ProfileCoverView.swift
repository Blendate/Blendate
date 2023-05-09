
//  ProfileCardView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/10/23.
//

import SwiftUI

struct ProfileCoverView<Buttons:View>: View {
    let user: User
    var superLiked: Bool = false
    @ViewBuilder let buttons: Buttons
    
    private let avatarSize: CGFloat = 200
    private var coverSize: (CGFloat,CGFloat) {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height/2.2
        return (width,height)
    }
    var body: some View {
        ZStack(alignment: .top) {
            PhotoView(url: user.cover, size: coverSize, shape: Rectangle())
            CardView(
                avatarUrl: user.avatar,
                avatarSize: avatarSize,
                superLiked: superLiked,
                title: SubtitleView(user: user),
                buttons: buttons
            )
            .padding(.top, avatarSize)
        }
    }

    struct SubtitleView: View {
        let user: User

        var children: Children { user.children }
        var childrenText: String {
            if user.children == 0 { return ""}
            return user.children == 1 ? "Child" : "Children"
        }
        
        var body: some View {
            VStack(spacing: 4) {
                Text(user.firstname + ", " + user.birthday.age.description)
                    .font(.title.weight(.semibold), .white)
                Text(user.location.name)
//                    .font(.title.weight(.semibold), .white)
                HStack(spacing: 4) {
                    if !user.isParent.rawValue {
                        Text("No Children")
                    } else {
                        Image(systemName: "figure.and.child.holdinghands")
//                        Text(childrenText)
                        Text(children.valueLabel)
                        Text(" | ")
                        Image(systemName: "birthday.cake")
                        if children.rawValue > 1 {
                            Text(user.childrenRange.valueLabel)
                        } else {
                            Text(user.childrenRange.min.description)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }

}

//struct ProfileCoverView_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollView {
//            ProfileCoverView(details: alice.details, info: alice.info) { MatchButtons { swipe in } }
//                .previewLayout(.sizeThatFits)
//                .previewDisplayName("Match")
//        }
//        .edgesIgnoringSafeArea(.top)
//    }
//}

