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
    @EnvironmentObject var auth: FirebaseAuthState
    
    @State var showPremium: Bool = false
    @State var alertError: AlertError?

    var hasPremium: Bool {
        session.user.premium.active
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                List {
                    Section {
                        Button {
                            session.showMembership = true
                        } label: {
                            Text(hasPremium ? "Manage Membership":"Premium Membership")
                        }

                        if hasPremium {
                            ToggleView("Invisivle Blending", value: $session.user.premium.invisbleBlending)
                            ToggleView("Hide Age", value: $session.user.premium.hideAge)
                        }

                        NavigationLink("Community", destination:
                            Text("Learn more info about upcoming community."))
                    } header: {
                        Text("Account")
                            .foregroundColor(.DarkBlue)
                            .fontWeight(.semibold)
                    }
                    
                    Section {
                        NavigationLink(destination: HelpCenterView()) {
                            Text("Help Center")
                        }
                        NavigationLink("Privacy Policy", destination:
                            Text("Privacy Policy") )
                        NavigationLink("About", destination:
                            Text("Blendate Mission") )
                    } header: {
                        Text("About")
                            .foregroundColor(.DarkBlue)
                            .fontWeight(.semibold)
                    }
                    
                    Section {
                        logoutButton
                        deleteButton
                    }
                }
                .listStyle(.grouped)
            }
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "Done") {
                    dismiss()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
//            .foregroundColor(.DarkBlue)
            .background(Color.LightGray)
            .navigationBarTitle("Settings")
            .errorAlert(error: $alertError, retry: delete)
//        }
    }
    
    
    var logoutButton: some View {
        Button{
            dismiss()
            try? auth.auth.signOut()
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
            self.alertError = AlertError(
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
        auth.auth.currentUser?.delete()
        try? auth.auth.signOut()

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject( SessionViewModel(user: dev.michael))
            .environmentObject(FirebaseAuthState())
    }
}


//    static func getUsersID(userId1: String, userId2: String) -> String {userId1 > userId2 ? userId1 + userId2 : userId2 + userId1}
//
//    func getProviders() -> [Provider]? {
//        guard let user = auth.currentUser else {return nil }
//
//        var providers = [Provider]()
//        for i in user.providerData {
//            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
//                switch i.providerID {
//                case "apple.com":
//                    providers.append(Provider(type: .apple, email: i.email) )
//                case "facebook.com":
//                    providers.append(Provider(type: .facebook, email: i.email) )
//                case "google.com":
//                    providers.append(Provider(type: .google, email: i.email) )
//                case "twitter.com":
//                    providers.append(Provider(type: .twitter, email: i.email) )
//                default:
//                    providers.append(Provider(type: .email, email: i.email) )
//                }
//            }
//        }
//        return providers
//    }
    

    
//    func getProvider() -> Provider? {
//        guard let user = auth.currentUser else {return nil }
//
//        for i in user.providerData {
//            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
//                switch i.providerID {
//                case "apple.com":
//                    return .apple
//                case "facebook.com":
//                    return Provider(type: .facebook, email: i.email ?? "")
//                case "google.com":
//                    return Provider(type: .google, email: i.email ?? "")
//                case "twitter.com":
//                    return Provider(type: .twitter, email: i.email ?? "")
//                default:
//                    return Provider(type: .email, email: i.email ?? "")
//                }
//            } else {
//                return nil
//            }
//        }
//        return nil
//    }
