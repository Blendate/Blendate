//
//  ProfileCard.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI


struct ProfileCardView: View {
    @EnvironmentObject var matchVM: MatchViewModel
    let profileType: ProfileType

    @Binding var details: UserDetails
    private let uid: String?
    @State var showSettings = false
    @State var showPref = false
    @State var showEdit = false

    private let avatarSize:CGFloat = 100
    
    init(_ details: Binding<UserDetails>, _ profileType: ProfileType, _ uid: String? = nil){
        self._details = details
        self.profileType = profileType
        self.uid = uid
    }
    
    
    var body: some View {
        let url = details.photos.first(where: {$0.placement == 1})?.url
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                CoverPhotoView(url: url)
                Spacer()
            }
            Card
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.78)
    }
    
    var Card: some View {
        let url = details.photos.first(where: {$0.placement == 0})?.url

        return ZStack(alignment: .top) {
            VStack {
                VStack {
                    Text(details.fullName() + ", " + "\(details.age())")
                    Text(details.location.name)
                }
                .fontType(.regular, 18, .white)
                .padding(.bottom)
                .padding(.top, avatarSize/1.5)
                ProfileButtons(profileType) { swipe in
                    matchVM.swipe(on: uid, swipe)
                }
            }
            .background(details.color.opacity(0.6))
            .mask(RoundedRectangle(cornerRadius: 25.0))
            .padding(.top, avatarSize/2)
            AvatarView(url: url, size: avatarSize)
        }
        .padding(.horizontal)
    }
    

}

struct ProfileCarView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileCardView(.constant(dev.michael.details), .view)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
        ProfileCardView(.constant(dev.michael.details), .match)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
        ProfileCardView(.constant(dev.michael.details), .session)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
    }
}


