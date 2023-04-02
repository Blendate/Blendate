//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct ProfileView: TabItemView {
    @Binding var user: User
    @Binding var settings: User.Settings
    
    @State private var tapped: ButtonType?
        
    @State private var showMembership = false
    @State private var showSuperLikes = false


    var body: some View {
        NavigationView {
            VStack {
                CardView(avatarUrl: user.details.avatar, avatarSize: 160, title: cardTitle, buttons: buttons)
                    .padding(.vertical)
                    .padding(.top, 32)
                superLikesButton
                premiumButton
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showMembership) { MembershipView() }
            .sheet(isPresented: $showSuperLikes) { PurchaseLikesView(settings: $settings) }
            .fullScreenCover(item: $tapped) { type in
                switch type {
                case .edit: EditStatsView(user: $user, settings: $settings, isFilter: false)
                case .filters: EditStatsView(user: $user, settings: $settings, isFilter: true)
                case .settings: SettingsView(settings: $settings)
                }
            }
        }
        .tag( Self.TabItem )
        .tabItem{ Self.TabItem.image }
    }

    private func tapped(_ type: ButtonType) {
        self.tapped = type
    }
    
    var cardTitle: some View {
        VStack(spacing: 0){
            Text(user.details.firstname + " " + user.details.lastname)
            Text(user.details.location.name)
        }
        .font(.title3)
        .padding(.vertical)
    }

    var buttons: some View {
        HStack {
            ProfileButton(type: .edit, user: $user, settings: $settings, tapped: tapped)
            Spacer()
            ProfileButton(type: .filters, user: $user, settings: $settings, tapped: tapped)
                .padding(.top)
            Spacer()
            ProfileButton(type: .settings, user: $user, settings: $settings, tapped: tapped)
        }
        .padding(.horizontal)
    }
}

extension ProfileView {
    
    var premiumButton: some View {
        Button{showMembership = true } label: {
            HStack {
                Image.Icon(size: 30, .Blue)
                Text("Premium Membership")
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.leading, 8)
        }
        .font(.title)
        .foregroundColor(.Blue)
        .padding(.horizontal)
    }
    
    var superLikesButton: some View {
        Button{
            showSuperLikes = true
        } label: {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.Purple)
                Text("Super Likes")
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .font(.title)
        .foregroundColor(.Purple)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

struct EditProfile_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ProfileView(user: .constant(alice), settings: .constant(User.Settings()))
    }
}
