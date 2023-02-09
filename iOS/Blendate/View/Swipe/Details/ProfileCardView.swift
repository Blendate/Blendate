//
//  ProfileCard.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

enum ProfileType { case view, match, session }

struct ProfileCardView: View {
    let details: User
    let type: ProfileType
    var swipe: (_ swipe: Swipe) async -> Void = {swipe in}
    
    var body: some View {
        if type == .session {
            ProfileCard(details: details, type: type)
        } else {
            cardWithCover
        }
    }
    
    var cardWithCover: some View {
        ZStack(alignment: .top) {
            PhotoView.Cover(url: details.cover)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.78)
            ProfileCard(details: details, type: type, swipe: swipe)
        }
    }
}

struct ProfileCard: View {
    let details: User
    let type: ProfileType
    var avatarSize:CGFloat = 250
    var padding: CGFloat { avatarSize/2 }

    var swipe: (_ swipe: Swipe) async -> Void = {swipe in}

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                VStack {
                    Text(details.firstname + ", " + details.ageString)
                        .fontType(.semibold, .title, .white)
                        .padding(.top, 8)
                    if type == .session {
                        Text(details.info.location.name)
                            .fontType(.semibold, .body, .white)
                    }
                    if type != .session {
                        children
                    }
                }
                .padding(.top, padding)
                matchButtons
            }
            .background(details.color.opacity(0.6))
            .mask(RoundedRectangle(cornerRadius: 25.0))
            .padding(.top, padding)
            PhotoView.Avatar(url: details.avatar, size: avatarSize)

//            PhotoView.Avatar(url: details.avatar, size: avatarSize)
        }
        .padding(.horizontal)
        .padding(.top, padding*2)
    }
    
    var children: some View {
        let children = details.info.children
        var childrenText: String {
            if children == 0 {
                return ""
            } else if children == 1 {
                return "Child"
            } else {
                return "Children"
            }
        }
        return HStack(spacing: 4) {
            if !details.info.isParent {
                Text("No Children")
            } else {
                Text(children.description)
                Text(childrenText)
                Text(" | ")
                if children > 1 {
                    Text("Ages:")
                    Text(details.info.childrenRange.label(min: 0, max: 21))
                } else {
                    Text("Age")
                    Text(details.info.childrenRange.min.description)
                }
            }
        }
        .fontType(.semibold, .body, .white)

    }
    var matchButtons: some View {
        HStack {
            if type == .match {
                Spacer()
                SwipeButton(swipe: .pass, action: swipe)
                Spacer()
                SwipeButton(swipe: .superLike, action: swipe)
                    .padding(.top)
                Spacer()
                SwipeButton(swipe: .like, action: swipe)
                Spacer()
            } else {
                Spacer()
            }
        }.padding([.bottom, .horizontal])
    }
}

struct ProfileCarView_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView {
            ProfileCardView(details: dev.michael, type: .match)
                .previewLayout(.sizeThatFits)
                .previewDisplayName("Match")
        }
        .edgesIgnoringSafeArea(.top)
        ProfileCardView(details: dev.michael, type: .view)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("View")

        ProfileCardView(details: dev.michael, type: .session)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Session")
    }
}


