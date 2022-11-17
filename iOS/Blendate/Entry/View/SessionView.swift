//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct SessionView: View {
    
    @StateObject var session: SessionViewModel
    @StateObject var matchVM = MatchViewModel()

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
    }
    
    var body: some View {
        LoadingView(showLoading: matchVM.loading == true) {
            switch session.loadingState {
            case .user:
                tabView
            case .noUser:
                signupView
            case .loading:
                Text("Loading")
            }
        }
        .environmentObject(session)
        .environmentObject(matchVM)
        .task {
            await session.getUserDoc()
        }
    }
    
    var signupView: some View {
        NavigationView {
            PropertyView(.name, signup: true)
        }
    }
    
    var tabView: some View {
        TabView(selection: $session.selectedTab) {
            MatchProfileView()
                .tag(0)
                .tabItem{ Image("icon-2") }
            MessagesView()
                .tag(1)
                .tabItem{ Image("chat") }
            CommunityView()
                .tag(2)
                .tabItem{Image(systemName: "person.3")}
            ProfileView($session.user)
                .tag(3)
                .tabItem{ Image("profile") }
        }.task {
            await session.checkNotification()
        }
    }
}


struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView("123")
    }
}
