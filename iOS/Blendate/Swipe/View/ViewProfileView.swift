//
//  ViewProfileView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/15/23.
//

import SwiftUI

struct ViewProfileView<Buttons:View>: View {
    let user: User
    var superLikedYou: Bool = false
    var reported: ()->Void
    @ViewBuilder var buttons: Buttons
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ProfileCoverView(user: user, superLiked: superLikedYou) { buttons }
            InfoCardsView(user: user)
            ProfileBioView(bio: user.bio)
            PhotosGridView(photos: user.photos)
            TagCloudView(interests: user.interests)
            ReportButton(uid: user.id, name: user.firstname, withName: true, reported: reported)
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

extension ViewProfileView {
    init(user: User, superLikedYou: Bool, reported: @escaping ()->Void, buttons: Buttons){
        self.user = user
        self.buttons = buttons
        self.superLikedYou = superLikedYou
        self.reported = reported
    }
    init(user: User, superLikedYou: Bool = false) where Buttons == HStack<Spacer> {
        self.user = user
        self.superLikedYou = superLikedYou
        self.buttons = HStack { Spacer() }
        self.reported = {}
    }
}

struct ViewProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ViewProfileView(user: alice)
        ViewProfileView(user: alice, reported: {}) { MatchButtons { swipe in } }
    }
}
