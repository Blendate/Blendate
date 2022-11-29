//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct ProfileView: View {
//    @EnvironmentObject var authState: FirebaseAuthState
    @StateObject var sheet = ProfileSheet()
    @Binding var user: User

    var body: some View {
        NavigationView {
            VStack {
                ProfileCardView(user, .session)
                    .padding(.vertical)
                VStack {
                    NavigationLink {
                        EditProfileView(details: $user)
                    } label: {
                        ButtonCell(title: "Edit Profile", systemImage: "pencil")
                    }
                    Divider()
                    NavigationLink {
                        FiltersView()
                    } label: {
                        ButtonCell(title: "Change Filters", systemImage: "cloud")
                    }
                    Divider()
                    NavigationLink {
                        SettingsView()
                    } label: {
                        ButtonCell(title: "App Settings", systemImage: "gear")
                    }

//                    ButtonCell(title: "Edit Profile", systemImage: "pencil")
//                    Divider()
//                    ButtonCell(title: "Change Filters", systemImage: "cloud")
//                    Divider()
//                    ButtonCell(title: "App Settings", systemImage: "gear")
                }
                Spacer()
                PremiumButton(isMembership: true)
                PremiumButton(isMembership: false)
                Spacer()
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .principal){
                    Image.icon(40).foregroundColor(.Blue)
                }
            }
            .environmentObject(sheet)
            .fullScreenCover(isPresented: $sheet.isShowing, onDismiss: save, content: sheetContent)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    struct PremiumButton: View {
        @EnvironmentObject var session: SessionViewModel
        let isMembership: Bool
        var title: String { isMembership ? "Premium Membership" : "Get more Super Likes"}
        var body: some View {
            Button {
                if isMembership {
                    session.showMembership = true
                } else {
                    session.showSuperLike = true
                }
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
    }
    
    struct ButtonCell: View {
//        @EnvironmentObject var sheet: ProfileSheet
//
//        let destination: ProfileSheet.State
        var title: String
        var systemImage: String?
        var image: String?
        
        
        var body: some View {
            
//            Button(action: {sheet.state = destination }) {
                HStack {
                    if let image = image {
                        Label(title, image: image)
                    }else if let systemImage = systemImage {
                        Label(title, systemImage: systemImage)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }
//            }
            .foregroundColor(.Blue)
            .font(.title2.weight(.semibold))
        }
    }
}

extension ProfileView {
    
    private func save() {
        do {
            try UserService().update(user)
        } catch {
            #warning("Add Popup")
        }
    }
    
    @ViewBuilder
    private func sheetContent() -> some View {
        switch sheet.state {
        case .edit:
            EditProfileView(details: $user)
        case .filter:
            FiltersView()
        case .settings:
            SettingsView()
        default:
            EmptyView()
        }
    }
}

struct EditProfile_Previews: PreviewProvider {
    @State static var show = true
    static var previews: some View {
        ProfileView(user: .constant(dev.michael))
    }
}

