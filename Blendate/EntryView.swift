//
//  EntryView.swift
//  Blendate
//
//  Created by Michael on 8/9/21.
//

import SwiftUI
import RealmSwift

struct EntryView: View {
    @EnvironmentObject var state: AppState
    @State var realm: Realm?
    @State var selectedTab: Int = 4
    @State var myUser: User?

    var body: some View {
        guard let _ = app.currentUser else {
            return AnyView(WelcomeView())
        }
        
        guard let realm = realm else {
            return AnyView(ProgressView() // Show the activity indicator while the realm loads
                            .onReceive(Realm.asyncOpen(configuration: UserConfig()).assertNoFailure()) { realm in
                                print(realm.objects(User.self).count)
                    self.realm = realm
                    if realm.objects(User.self).first?.userPreferences != nil {
                        state.currentView = .session
                    } else {
                        state.currentView = .onboarding
                    }
                    state.user = realm.objects(User.self).first
                })
        }
        if state.currentView == .session {
            return AnyView(
                MyTabView(selectedTab: $selectedTab, user: realm.objects(User.self).first!)
                    .onReceive(Realm.asyncOpen(configuration: MatchUserConfig()).assertNoFailure()) { realm in
                        let lineup = realm.objects(MatchUser.self)
                        print("Linup: \(lineup.count)")
                        if lineup.count >= 11 {
                            for i in 0...10{
                                if !state.lineup.contains(lineup[i]) && lineup[i].identifier != state.user?.identifier {
                                    self.state.lineup.append(lineup[i])
                                }
                            }
                        } else {
                            for matchUser in lineup {
                                if !state.lineup.contains(matchUser) && matchUser.identifier != state.user?.identifier {
                                    self.state.lineup.append(matchUser)
                                }
                            }
                        }
                    }

            )
        } else {
            return AnyView(
                SignupView()
                    .environment(\.realmConfiguration, UserConfig())
            )
        }
    }

}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
