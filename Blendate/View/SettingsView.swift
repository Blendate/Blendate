//
//  SettingsView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var session: Session
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.DarkBlue)]
    }
    
    var body: some View {
        List {
            NavigationLink(
                destination: AccountSettingsView(),
                label: {
                    Text("Account Settings")
                })
            NavigationLink(
                destination: AccountSettingsView(),
                label: {
                    Text("FAQ")
                })
            NavigationLink(
                destination: AccountSettingsView(),
                label: {
                    Text("Switch to Community")
                })
            Section {
                HStack {
                    Text("Logout").foregroundColor(.red)
                    Spacer()
                    Image("log_out")
                }.onTapGesture {
                    session.logout()
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Settings")
    }
}

struct AccountSettingsView: View {
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.DarkBlue)]
    }
    
    var body: some View {
        List {
            Section {
                NavigationLink(
                    destination: Text("Verify Phone"),
                    label: {
                        Text("Verify Phone")
                    })
                NavigationLink(
                    destination: Text("Change Email"),
                    label: {
                        Text("Change Email")
                    })
                NavigationLink(
                    destination: Text("Reset Password"),
                    label: {
                        Text("Reset Password")
                    })
            }
            Section {
                NavigationLink(
                    destination: Text("Upgrade to Premium"),
                    label: {
                        Text("Upgrade to Premium")
                    })
                NavigationLink(
                    destination: Text("Switch to Community"),
                    label: {
                        Text("Switch to Community")
                    })
            }
            Toggle(isOn: .constant(true), label: {
                Text("Push Notifications")
            })
            Toggle(isOn: .constant(true), label: {
                Text("Discoverable")
            })
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Account Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
