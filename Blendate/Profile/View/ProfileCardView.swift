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

    var details: Details
    private let uid: String?
    @State var showSettings = false
    @State var showPref = false
    @State var showEdit = false

    private let avatarSize:CGFloat = 100
    
    init(_ details: Details, _ profileType: ProfileType, _ uid: String? = nil){
        self.details = details
        self.profileType = profileType
        self.uid = uid
    }
    
    
    var body: some View {
        Group {
            switch profileType {
            case .view:
                cardWithCover
            case .match:
                cardWithCover
            case .session:
                Card
            }
        }
    }
    
    var cardWithCover: some View {
        let request = details.photos.first(where: {$0.placement == 1})?.request
        return ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                PhotoView.Cover(request: request)
                Spacer()
            }
            Card
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.78)
    }
    
    var Card: some View {
        let request = details.photos.first(where: {$0.placement == 0})?.request

        return ZStack(alignment: .top) {
            VStack {
                if profileType != .session {
                    VStack {
                        Text(details.fullName + ", " + "\(details.age)")
                        Text(details.info.location.name)
                    }
                    .fontType(.regular, 18, .white)
                    .padding(.bottom)
                    .padding(.top, avatarSize/1.5)
                } else {
                    Rectangle().fill(Color.clear)
                        .frame(height: avatarSize/2)
                }
                ProfileButtons(profileType) { swipe in
                    matchVM.swipe(on: uid, swipe)
                }
            }
            .background(details.color.opacity(0.6))
            .mask(RoundedRectangle(cornerRadius: 25.0))
            .padding(.top, avatarSize/2)
            PhotoView.Avatar(request: request, size: avatarSize)
        }
        .padding(.horizontal)
    }
    

}

struct ProfileCarView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileCardView(dev.michael.details, .view)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
        ProfileCardView(dev.michael.details, .match)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
        ProfileCardView(dev.michael.details, .session)
            .environmentObject(dev.profilesheet)
            .previewLayout(.sizeThatFits)
    }
}


