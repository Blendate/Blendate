//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

enum SessionState {case noUser, user, loading}

struct SessionView: View {
    
    @StateObject var session: SessionViewModel
    @StateObject var matchVM: MatchViewModel
    @StateObject var messageVM: MessagesViewModel

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
        self._matchVM = StateObject(wrappedValue: MatchViewModel())
        self._messageVM = StateObject(wrappedValue: MessagesViewModel())
    }
    
    var body: some View {
        LoadingView(showLoading: matchVM.loading == true) {
            if session.loadingState == .noUser {
                SignupViewContainer()
            } else if session.loadingState == .user {
                TabView(selection: $session.selectedTab) {
                    MatchProfileView()
                        .transition(.opacity)
                        .tabItem{
                            Image("icon-2")
                        }
                        .tag(0)
                    MessagesView()
                        .tabItem{
                            Image("chat")
                        }
                        .tag(1)

                    TodayView()
                        .tabItem{
                            Image("heart")
                        }
                        .tag(2)

                    ProfileView($session.user)
                        .tabItem{
                            Image("profile")
                        }
                        .tag(3)

                }.task {
                    await session.checkNotification()
                }
            }
        }
        .environmentObject(session)
        .environmentObject(matchVM)
        .environmentObject(messageVM)

        .task {
            await session.getUserDoc()
            await matchVM.getLineup()
        }
    }

}




struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView("123")
    }
}
