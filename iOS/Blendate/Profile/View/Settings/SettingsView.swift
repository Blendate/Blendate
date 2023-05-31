//
//  SettingsView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var userModel: UserViewModel
    @EnvironmentObject var navigation: NavigationManager
    @EnvironmentObject var entitlement: StoreManager
    
    @Binding var settings: User.Settings
    
    var hasMembership: Bool { entitlement.hasMembership }
    
    @State var alert: ErrorAlert?
    @State private var showSuperLikes = false
    @State private var showMembership = false


    var body: some View {
        NavigationStack {
            List {
                notifications
                accountSection
                legalSection
                buttonsSection
            }
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "Done") { dismiss() }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Settings")
            .sheet(isPresented: $showSuperLikes) {
                PurchaseLikesView(settings: $settings)
            }
            .fullScreenCover(isPresented: $showMembership) {
                MembershipView()
            }
            .errorAlert(error: $alert) { error in
                if error.title == "Logout" {
                    Button("Logout", role: .destructive, action: logout)
                    Button("Cancel", role: .cancel){}
                } else {
                    Button("Delete", role: .destructive, action: delete)
                    Button("Cancel", role: .cancel){}
                }
            }
        }
    }
    
    var notifications: some View {
        Section {
            HStack {
                Image(systemName: "bell")
                Toggle("Notfications", isOn: $settings.notifications.isOn).tint(.Blue)
            }
            if settings.notifications.isOn {
                HStack {
                    if !hasMembership {
                        Image(systemName: "lock")
                    }
                    Toggle("Liked You", isOn: $settings.notifications.likes)
                        .tint(.Blue)
                }
                    .disabled(!hasMembership)
                    .onTapGesture {
                        if !hasMembership {
                            showMembership = true
                        }
                    }
            }
        } header: {
            Text("Notifications")
                .foregroundColor(.DarkBlue)
                .fontWeight(.semibold)
        }
    }
    
    var accountSection: some View {
        Section {
            Button {
                showMembership = true
            } label: {
                HStack {
                    Image("icon-2")
                        .foregroundColor(.primary)
                    Text(hasMembership ? "Manage Membership":"Premium Membership")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(hasMembership ? "Active" : "Purchase")
                        .foregroundColor(.Blue)
                }
            }
            Button {
                showSuperLikes = true
            } label: {
                HStack {
                    Image(systemName: "star")
                        .foregroundColor(.primary)
                    Text("Super Likes")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(settings.premium.superLikes.description)
                        .foregroundColor(.Purple)
                        .fontWeight(.bold)
                }
            }
//            if let provider = auth.provider {
//                HStack {
//                    Image(systemName: "person")
//                    Text(provider.0.rawValue)
//                    Spacer()
//                    Text(provider.1 ?? "")
//                }
//            }
//            NavigationLink {
//                Text("Learn more info about upcoming community.")
//            } label: {
//                HStack {
//                    Image(systemName: "person.3.sequence")
//                    Text("Community")
//                    Spacer()
//                }
//            }

        } header: {
            Text("Account")
                .foregroundColor(.DarkBlue)
                .fontWeight(.semibold)
        }
    }
    
    var legalSection: some View {
        Section {
//            NavigationLink(destination: HelpCenterView()) {
//                HStack {
//                    Image(systemName: "info.circle")
//                    Text("Help Center")
//                    Spacer()
//                }
//            }
            Link(destination: URL(string: String.PivacyLink)!) {
                HStack {
                    Image(systemName: "doc.plaintext")
                    Text("Privacy Policy")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
            }
            Link(destination: URL(string: String.TermsLink)!) {
                HStack {
                    Image(systemName: "doc.plaintext")
                    Text("Terms of Use")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
            }
            Link(destination: URL(string: String.PivacyLink)!) {
                HStack {
                    Image(systemName: "doc.plaintext")
                    Text("Legal")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.primary)
            }
//            NavigationLink(destination: Text("Blendate Mission")) {
//                HStack {
//                    Image("icon-2")
//                    Text("About")
//                    Spacer()
//                }
//            }
        } header: {
            Text("Blendate")
                .foregroundColor(.DarkBlue)
                .fontWeight(.semibold)
        }
    }
    
    var buttonsSection: some View {
        Section {
            logoutButton
            deleteButton
        }
    }
}

extension SettingsView {

    var logoutButton: some View {
        Button{
            self.alert = Error(title: "Logout", message: "Are you sure you want to logout?")
        } label: {
            HStack {
                Spacer()
                Text("Logout")
                    .foregroundColor(.red)
                Spacer()
            }
        }
    }
    
    var deleteButton: some View {
        Button{
            self.alert = Error(title: "Delete Account", message: "Are you sure you want to delete your account?")
        } label: {
            HStack {
                Spacer()
                Text("Delete Account")
                    .foregroundColor(.red)
                Spacer()
            }
        }
    }
        
    private func delete(){
        navigation.delete(uid: userModel.uid)
        dismiss()

    }
    
    private func logout(){
        navigation.signOut()
        dismiss()
    }
}

extension SettingsView {
    struct Error: ErrorAlert {
        var title: String
        var message: String
    }
}

//extension FirebaseAuthState {
//    var provider: (Provider, String?)? {
//        guard let user = auth.currentUser else {return nil }
//        let email = user.email
//        let phone = user.phoneNumber
//        for i in user.providerData {
//            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
//                switch i.providerID {
//                case "apple.com":
//                    return (.apple, email)
//                case "facebook.com":
//                    return (.facebook, email ?? phone)
//                default:
//                    return (.phone, phone)
//                }
//            }
//        }
//        return nil
//    }
//}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(settings: .constant(User.Settings()))
            .environmentObject(NavigationManager.shared)
            .environmentObject(StoreManager())
    }
}



    

