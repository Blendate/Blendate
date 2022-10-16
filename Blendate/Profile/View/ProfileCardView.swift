//
//  ProfileCard.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

enum ProfileType { case view, match, session }

struct ProfileCard: View {
    let details: Details
    let profileType: ProfileType
    
    var swipe: (_ swipe: Swipe) -> Void
    private let avatarSize:CGFloat = 150
    
    init(details: Details, profileType: ProfileType, _ swipe: (@escaping (_: Swipe) -> Void) = {swipe in} ) {
        self.details = details
        self.profileType = profileType
        self.swipe = swipe
    }
    
    var request: URLRequest? { details.photos.first(where: {$0.placement == 0})?.request }

    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                VStack {
                    Text(details.firstname + ", " + "\(details.age)")
                        .fontType(.semibold, .title, .white)
                    Text(details.info.location.name)
                        .fontType(.semibold, .body, .white)

                }
                .padding(.bottom)
                .padding(.top, avatarSize/1.5)
                ProfileButtons(profileType, didSwipe: swipe)
            }
            .background(details.color.opacity(0.6))
            .mask(RoundedRectangle(cornerRadius: 25.0))
            .padding(.top, avatarSize/2)
            PhotoView.Avatar(request: request, size: avatarSize)
        }
        .padding(.horizontal)
    }
}

struct ProfileCardView: View {
    let profileType: ProfileType
    let details: Details
    var swipe: (_ swipe: Swipe) -> Void
    
    init(_ details: Details, _ profileType: ProfileType, swipe: (@escaping (_: Swipe) -> Void) = {swipe in}){
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
        let request = details.photos.first(where: {$0.placement == 1})?.request
        return ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                PhotoView.Cover(request: request)
                Spacer()
            }
            ProfileCard(details: details, profileType: profileType, swipe)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.78)
    }
}

struct ProfileCarView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileCardView(dev.michael.details, .view)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("View")
        ProfileCardView(dev.michael.details, .match)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Match")
        ProfileCardView(dev.michael.details, .session)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
            .previewDisplayName("Session")

    }
}


