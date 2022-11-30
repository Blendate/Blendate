//
//  ProfileCard.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

enum ProfileType { case view, match, session }



struct ProfileCardView: View {
    let profileType: ProfileType
    let details: User
    var swipe: (_ swipe: Swipe) -> Void
    
    init(_ details: User, _ profileType: ProfileType, swipe: (@escaping (_: Swipe) -> Void) = {swipe in}){
        self.details = details
        self.profileType = profileType
        self.swipe = swipe
    }
    
    
    var body: some View {
        if profileType == .session {
            ProfileCard(details: details, profileType: profileType)
        } else {
            cardWithCover
        }
    }
    
    var cardWithCover: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                PhotoView.Cover(url: details.cover)
                Spacer()
            }
            ProfileCard(details: details, profileType: profileType, swipe)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.78)
    }
}

struct ProfileCard: View {
    let details: User
    let profileType: ProfileType
    
    var swipe: (_ swipe: Swipe) -> Void
    private let avatarSize:CGFloat = 150
    
    init(details: User, profileType: ProfileType, _ swipe: (@escaping (_: Swipe) -> Void) = {swipe in} ) {
        self.details = details
        self.profileType = profileType
        self.swipe = swipe
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                VStack {
                    Text(details.firstname + ", " + details.ageString)
                        .fontType(.semibold, .title, .white)
                    Text(details.info.location.name)
                        .fontType(.semibold, .body, .white)
                }
                .padding(.bottom)
                .padding(.top, avatarSize/1.5)
                matchButtons
            }
            .background(details.color.opacity(0.6))
            .mask(RoundedRectangle(cornerRadius: 25.0))
            .padding(.top, avatarSize/2)
            PhotoView.Avatar(url: details.avatar, size: avatarSize)
        }
        .padding(.horizontal)
    }
    
    var matchButtons: some View {
        HStack {
            if profileType == .match {
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
        ProfileCardView(dev.michael, .view)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("View")
        ProfileCardView(dev.michael, .match)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Match")
        ProfileCardView(dev.michael, .session)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Session")

    }
}

