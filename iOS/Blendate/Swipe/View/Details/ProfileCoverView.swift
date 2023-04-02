
//  ProfileCardView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/10/23.
//

import SwiftUI

struct ProfileCoverView<Buttons:View>: View {
    let details: User.Details
    let info: Stats
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
            PhotoView(url: details.cover, size: coverSize, shape: Rectangle())
            CardView(
                avatarUrl: details.avatar,
                avatarSize: avatarSize,
                superLiked: superLiked,
                title: SubtitleView(details: details, info: info),
                buttons: buttons
            )
            .padding(.top, avatarSize)
        }
    }

    struct SubtitleView: View {
        let details: User.Details
        let info: Stats

        var children: Int { info.children ?? 0 }
        var childrenText: String {
            if info.children == 0 { return ""}
            return info.children == 1 ? "Child" : "Children"
        }
        
        var body: some View {
            VStack(spacing: 4) {
                Text(details.firstname + ", " + details.birthday.age.description)
                    .font(.title.weight(.semibold), .white)
                Text(details.location.name)
//                    .font(.title.weight(.semibold), .white)
                HStack(spacing: 4) {
                    if !info.isParent {
                        Text("No Children")
                    } else {
                        Image(systemName: "figure.and.child.holdinghands")
//                        Text(childrenText)
                        Text(children.description)
                        Text(" | ")
                        Image(systemName: "birthday.cake")
                        if children > 1 {
                            Text(info.childrenRange?.label(min: IntRange.KKidMin, max: IntRange.KKidMax) ?? "Has children")
                        } else {
                            Text(info.childrenRange?.min.description ?? "Baby" )
                        }
                    }
                }
            }
            .padding(.vertical)
        }
    }

}

struct ProfileCoverView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ProfileCoverView(details: alice.details, info: alice.info) { MatchButtons { swipe in } }
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Match")
        }
        .edgesIgnoringSafeArea(.top)
    }
}

