//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct ProfileView: View {
    //    @EnvironmentObject var authState: FirebaseAuthState
    @Binding var user: User
    @State private var showSettings = false
    @State private var showFilters = false
    @State private var showProfile = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                PremiumButton(isMembership: true)
                    .padding(.top)
                PremiumButton(isMembership: false)
                ProfileCardView(user, .session)
                    .padding(.vertical)
                VStack {
                    ButtonCell(title: "Edit Profile", systemImage: "pencil"){
                        showProfile = true
                    }
                    Divider()
                    ButtonCell(title: "Change Filters", systemImage: "slider.horizontal.3") {
                        showFilters = true
                    }
                    Divider()
                    ButtonCell(title: "App Settings", systemImage: "gear") {
                        showSettings = true
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .principal){
                    Image.icon(40).foregroundColor(.Blue)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .fullScreenCover(isPresented: $showProfile) { EditProfileView(details: $user) }
            .fullScreenCover(isPresented: $showFilters) { FiltersView() }
            .fullScreenCover(isPresented: $showSettings) { SettingsView() }
            
        }
    }
}


extension ProfileView {
    
    struct PremiumButton: View {
        @EnvironmentObject var session: SessionViewModel
        let isMembership: Bool
        var title: String { isMembership ? "Premium Membership" : "Get more Super Likes"}
        var body: some View {
            Button {
                tapped()
            } label: {
                HStack {
                    image
                        .foregroundColor(isMembership ? Color.Blue : Color.DarkPink)
                        .padding()
                        .background(.white)
                        .clipShape(Circle())
                    Text(title)
                        .fontType(.semibold, .title2, .white)
                        .padding(.leading, 6)
                    Spacer()

                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(isMembership ? Color.Blue : Color.DarkPink)
                .cornerRadius(16)
            }

        }
        
        var image: some View {
            Group {
                if isMembership {
                    Image.icon(25)
                } else {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            }
        }
        
        @MainActor
        func tapped(){
            if isMembership {
                session.showMembership = true
            } else {
                session.showSuperLike = true
            }
        }
    }
    
    struct ButtonCell: View {
//        @EnvironmentObject var sheet: ProfileSheet
//
//        let destination: ProfileSheet.State
        var title: String
        var systemImage: String?
        var image: String?
        var action: ()->Void
        
        
        var body: some View {
            
            Button(action: action) {
                HStack {
                    if let image = image {
                        Label(title, image: image)
                    }else if let systemImage = systemImage {
                        Label(title, systemImage: systemImage)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.Blue)
            .font(.title3.weight(.semibold))
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ProfileView(user: .constant(dev.michael))
    }
}

