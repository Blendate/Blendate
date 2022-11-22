//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var sheet = ProfileSheet()
    @Binding var user: User
    @Binding var details: Details

    var body: some View {
        NavigationView {
            VStack(spacing: 22) {
                ProfileCardView(details, .session)
                    .padding(.top)
                Spacer()
                upgrade
                likes
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Image.icon(40).foregroundColor(.Blue)
                }
            }
            .environmentObject(sheet)
            .fullScreenCover(isPresented: $sheet.isShowing, onDismiss: save, content: sheetContent)
//            .sheet(isPresented: $sheet.isShowing, onDismiss: save, content: sheetContent)
            .navigationBarTitleDisplayMode(.inline)
        }

    }
    
    var upgrade: some View {
        HStack {
            Image.icon(25)
                .foregroundColor(.Blue)
                .padding()
                .background(.white)
                .clipShape(Circle())
            Text("Premium Membership")
                .fontType(.semibold, .title2, .white)
                .fixedSize()
                .padding(.leading)
        }
        .padding()
        .background(Color.Blue)
        .cornerRadius(16)
    }
    
    var likes: some View {
        HStack {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(.DarkBlue)
                .padding()
                .background(.white)
                .clipShape(Circle())
            Text("Get more Super Likes")
                .fontType(.semibold, .title2, .white)
                .fixedSize()
                .padding(.leading)

        }
        .padding()
        .background(Color.DarkBlue)
        .cornerRadius(16)
    }
}

extension ProfileView {
    
    private func save() {
        do {
            try DetailService().update(details)
        } catch {
            #warning("Add Popup")
        }
    }
    
    @ViewBuilder
    private func sheetContent() -> some View {
        switch sheet.state {
        case .edit:
            EditProfileView(details: $details)
        case .filter:
            FiltersView()
        case .settings:
            SettingsView(user: $user)
        default:
            EmptyView()
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ProfileView(user: .constant(dev.michael), details: .constant(dev.details))
    }
}

