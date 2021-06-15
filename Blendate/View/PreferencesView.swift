//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct PreferencesView: View {
    
//    init(){
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.DarkBlue)]
//    }
    
    @Binding var user: User
    
    var body: some View {
        List {
            Section(header: Text("Basic Preferences")) {
                NavigationLink(
                    destination: GenderView(false, $user),
                    label: {
                        Text("I am")
                    })
                NavigationLink(
                    destination: GenderView(false, $user),
                    label: {
                        Text("I'm interested in")
                    })
                NavigationLink(
                    destination: LocationView(false, $user),
                    label: {
                        Text("Location")
                    })
            }
            Section(header: Text("Preferred Preferences")) {
                NavigationLink(
                    destination: KidsRangeView(false, $user),
                    label: {
                        Text("Age Range")
                })
                NavigationLink(
                    destination: Text("Maximum Distance"),
                    label: {
                        Text("Maximum Distance")
                })
                NavigationLink(
                    destination: EthnicityView(false, $user),
                    label: {
                        Text("Ethnicity")
                })
                NavigationLink(
                    destination: ReligionView(false, $user),
                    label: {
                        Text("Religion")
                })
                NavigationLink(
                    destination: HeightView(false, $user),
                    label: {
                        Text("Height")
                })
                NavigationLink(
                    destination: WantKidsView(false, $user),
                    label: {
                        Text("Family Plans")
                })
                NavigationLink(
                    destination: PoliticsView(false, $user),
                    label: {
                        Text("Politics")
                })
                NavigationLink(
                    destination: VicesView(false, $user),
                    label: {
                        Text("Drinking")
                })
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Preferences")
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(user: .constant(Dummy.user))
    }
}
