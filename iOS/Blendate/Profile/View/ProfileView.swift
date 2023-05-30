//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var model: UserViewModel

    @State var settings: User.Settings = .init()
    @State private var tapped: ButtonType?

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                CardView(avatarUrl: model.user.avatar, avatarSize: 160, title: cardTitle, buttons: buttons)
                    .padding(.vertical)
                    .padding(.top, 32)
                Spacer()
                ProfileButtonLong(title: "Membership") {
                    navigation.showPurchaseMembership = true
                }.padding(.horizontal)
                ProfileButtonLong(title: "Super Likes", subtitle: "\(settings.premium.superLikes)", systemImage: "star.fill",color: .Purple) {
                    navigation.showPurchaseLikes = true
                }.padding(.horizontal)
                Spacer()
            }
            .background(text: nil, bottom: false)
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(item: $tapped, onDismiss: model.save) { type in
                switch type {
                case .edit: EditProfileView()
                case .filters: FiltersView()
                case .settings: SettingsView(settings: $settings)
                }
            }
            .errorAlert(error: $model.error) { alert in
                Button("Try again", action: model.save)
                Button("Cancel", role: .cancel){}
            }
        }
    }

    
    var cardTitle: some View {
        VStack(spacing: 0){
            Text(model.user.firstname + " " + model.user.lastname)
            Text(model.user.location.name)
        }
        .font(.title3)
        .padding(.vertical)
    }

    var buttons: some View {
        HStack {
            ProfileButton(type: .edit, tapped: tapped)
            Spacer()
            ProfileButton(type: .filters, tapped: tapped)
                .padding(.top)
            Spacer()
            ProfileButton(type: .settings, tapped: tapped)
        }
        .padding(.horizontal)
    }
    
    private func tapped(_ type: ButtonType) {
        self.tapped = type
    }
    
}

struct EditProfile_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ProfileView()
            .environmentObject(session)
            .environmentObject(NavigationManager())
    }
}
