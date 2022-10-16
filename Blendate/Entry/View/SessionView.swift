//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI


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
//        LoadingView(showLoading: matchVM.loading == true) {
//
//        }
        Group {
            if session.loadingState == .noUser {
                SignupViewContainer()
            } else if session.loadingState == .user {
                Text("Yoo")
//                TabView(selection: $session.selectedTab) {
//                    MatchProfileView().tag(0)
//                    MessagesView().tag(1)
//                    CommunityView().tag(2)
//                    ProfileView($session.user).tag(3)
//                }.task {
//                    await session.checkNotification()
//                }
            } else {
                Text("Loading")
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
