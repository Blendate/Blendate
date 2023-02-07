//
//  SettingsView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var session: SessionViewModel
    @EnvironmentObject var premium: SettingsViewModel
    @EnvironmentObject var auth: FirebaseAuthState
    
    @State var logoutAlert: AlertError?
    @State var deleteAlert: AlertError?
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
            .errorAlert(error: $deleteAlert, retry: delete)
            .errorAlert(error: $logoutAlert, retry: logout)
            .fullScreenCover(isPresented: $showMembership) {
                MembershipView()
            }
        }
    }
    
    var notifications: some View {
        Section {
            ToggleView("Noticications", value: $premium.settings.notifications.isOn)
            if premium.settings.notifications.isOn {
                ToggleView("New Messages", value: $premium.settings.notifications.messages)
                ToggleView("New Match", value: $premium.settings.notifications.matches)
                HStack {
                    if !premium.hasPremium {
                        Image(systemName: "lock")
                    }
                    ToggleView("Liked You", value: $premium.settings.notifications.likes)
                }
                    .disabled(!premium.hasPremium)
                    .onTapGesture {
                        if !premium.hasPremium {
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
                    Text(premium.hasPremium ? "Manage Membership":"Premium Membership")
                        .foregroundColor(.primary)
                    Spacer()
                    Text(premium.hasPremium ? "Active" : "Purchase")
                        .foregroundColor(.Blue)
                }
            }
            if let provider = auth.provider {
                HStack {
                    Text(provider.0.rawValue)
                    Spacer()
                    Text(provider.1 ?? "")
                }
            }

            NavigationLink("Community", destination:
                Text("Learn more info about upcoming community."))
        } header: {
            Text("Account")
                .foregroundColor(.DarkBlue)
                .fontWeight(.semibold)
        }
    }
    
    var legalSection: some View {
        Section {
            NavigationLink(destination: HelpCenterView()) {
                Text("Help Center")
            }
            NavigationLink("Privacy Policy", destination:
                Text("Privacy Policy") )
            NavigationLink("About", destination:
                Text("Blendate Mission") )
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
            self.deleteAlert = AlertError(
                title: "Logout",
                message: "Are you sure you want to logout?",
                recovery: "Logout",
                destructive: true)
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
            self.deleteAlert = AlertError(
                title: "Delete Account",
                message: "Are you sure you want to delete your account?",
                recovery: "Delete",
                destructive: true)

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
        dismiss()
        auth.delete()

    }
    
    private func logout(){
        dismiss()
        auth.signout()
    }
    

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SessionViewModel(user: dev.michael))
            .environmentObject(FirebaseAuthState())
            .environmentObject(SettingsViewModel(dev.michael.id!))
    }
}



    

