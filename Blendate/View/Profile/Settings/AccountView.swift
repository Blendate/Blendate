//
//  SettingsView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct AccountView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState

    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.Blue!]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.Blue!]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        PreferenceCell2(title: "Email", value: state.user?.identifier) {}
                        PreferenceCell2(title: "Password Reset", value: nil, true) {}
                        PreferenceCell2(title: "Push Notifiations", value: nil, toggle: true) {}
                        PreferenceCell2(title: "Invisble Blending", value: nil,  toggle: true) {}
                        PreferenceCell2(title: "Help Center", value: nil, true) {}
                        PreferenceCell2(title: "Membership", value: nil, true) {}
                        PreferenceCell2(title: "Blendate Community", value: nil,true) {}
                        PreferenceCell2(title: "Logout", value: nil,true) {logout()}
                    }
                }.padding()
            }
            .navigationBarItems(leading:
                        BackButton(signup: true, isTop: false) {
                            mode.wrappedValue.dismiss()
                        }
            )
            .navigationBarTitle("Account Settings", displayMode: .inline)
        }
    }
    
    var helpCenter: some View {
        NavigationLink(
            destination: HelpCenterView(),
            label: {
                VStack(alignment: .leading) {
                    Text("Help Center")
                        .lexendDeca(.semibold, 24)
                        .padding(.top)
                        .padding(.bottom, 10)
                    HStack {
                        Text("Learn more about Blendate")
                            .lexendDeca()
                            .foregroundColor(.gray)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.Blue)
                    }.padding(.horizontal)
                    Divider()
                }
            }).foregroundColor(.black)
    }
    
    private func logout() {
//        app.currentUser?.logOut()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in
//            }, receiveValue: {
//                state.shouldIndicateActivity = false
//                state.logoutPublisher.send($0)
//            })
//            .store(in: &state.cancellables)
    }
    
    var logoutButton: some View {
        VStack {
            HStack {
                Text("Logout")
                    .lexendDeca(.bold,28)
                    .foregroundColor(.red)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.red)
            }.padding(.horizontal)
            .onTapGesture {
                logout()
            }
            Rectangle().frame(height: 100).foregroundColor(.clear)
        }
    }
    
    var membership: some View {
        VStack(alignment: .leading) {
            Text("Membership")
                .lexendDeca(.semibold, 24)
                .padding(.top)
                .padding(.bottom, 10)
            HStack {
                Text("Upgrade to Premium Membership")
                    .lexendDeca()
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.Blue)
            }.padding(.horizontal)
            Divider()
        }
    }
    
    var community: some View {
        VStack(alignment: .leading) {
            Text("Blendate Community ")
                .lexendDeca(.semibold, 24)
                .padding(.top)
                .padding(.bottom, 10)
            HStack {
                Spacer()
                Toggle(isOn: .constant(true), label: {
                    Text("Switch modes to Blendate Community")
                        .lexendDeca()
                        .foregroundColor(.gray)
                })
                .padding(.horizontal, 5)
                .toggleStyle(SwitchToggleStyle(tint: .Blue))
            }
            Divider()
        }
    }
    
    var notifications: some View {
        VStack(alignment: .leading) {
            Text("Notifications")
                .lexendDeca(.semibold, 24)
                .padding(.top)
                .padding(.bottom, 10)
            HStack {
                Spacer()
                Toggle(isOn: .constant(true), label: {
                    Text("Push Notifications")
                        .lexendDeca()
                        .foregroundColor(.gray)
                })
                .padding(.horizontal, 5)
                .toggleStyle(SwitchToggleStyle(tint: .Blue))
            }
            Divider()
        }
    }
    
    var invisible: some View {
        VStack(alignment: .leading) {
            Text("Invisible Blending")
                .lexendDeca(.semibold, 24)
                .padding(.top)
                .padding(.bottom, 10)
            HStack {
                Spacer()
                Toggle(isOn: .constant(true), label: {
                    Text("Discover matches without being seen")
                        .lexendDeca()
                        .foregroundColor(.gray)
                })
                .padding(.horizontal, 5)
                .toggleStyle(SwitchToggleStyle(tint: .Blue))
            }
            Divider()
        }
    }
    
    var language: some View {
        VStack(alignment: .leading) {
            Text("Language")
                .lexendDeca(.semibold, 24)
                .padding(.top)
                .padding(.bottom, 10)
            HStack {
                Text("English")
                    .lexendDeca()
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.Blue)
            }.padding(.horizontal)
            Divider()
        }
    }
    
    var password: some View {
        VStack(alignment: .leading) {
            Text("Password")
                .lexendDeca(.semibold, 24)
                .padding(.top)
                .padding(.bottom, 10)
            HStack {
                Text("Reset Password")
                    .lexendDeca()
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.Blue)
            }.padding(.horizontal)
            Divider()
        }
    }
    
    var contacts: some View {
        VStack(alignment: .leading) {
            Text("Contact")
                .lexendDeca(.semibold, 24)
                .padding(.top)
                .padding(.bottom, 10)
            
            NavigationLink(
                destination: Text("PhoneView PlaceHolder"),
                label: {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Email : ")
                                .lexendDeca(.regular, 12)
                                .foregroundColor(.gray)
                            Text("\(state.user?.identifier ?? "Identifier")")
                                .lexendDeca(.regular, 16)
                                .foregroundColor(.gray)
                        }
                        Divider()
                    }
                }).padding([.horizontal, .bottom])
        }
    }
    

}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AccountView()
                .environmentObject(AppState())
        }
    }
}
