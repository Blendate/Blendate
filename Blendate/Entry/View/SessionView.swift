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

    init(_ uid: String){
        self._session = StateObject(wrappedValue: SessionViewModel(uid))
        self._matchVM = StateObject(wrappedValue: MatchViewModel())

    }
    
    var body: some View {
        LoadingView(showLoading: session.loadingState == .loading && matchVM.loading == true) {
            if session.loadingState == .noUser {
                SignupView(user: $session.user)
            } else if session.loadingState == .user {
                tabBar
            }
        }
        .environmentObject(session)
        .environmentObject(matchVM)
        .task {
            await session.getUserDoc()
            await matchVM.getLineup()
        }
    }
    
    @ViewBuilder
    var tabBar: some View {
//        if vm.user.settings.dev?.classicTab ?? false {
//            ClassicTabBar($vm.user, $vm.selectedTab)
//        } else {
//            SessionTabsView($vm.user, $vm.selectedTab)
//        }
        ClassicTabBar($session.user, $session.selectedTab)
    }

}

@MainActor
class SessionViewModel: ObservableObject {

    @Published var selectedTab: Int = 0
    @Published var user: User = User()
    @Published var loadingState: SessionState = .loading

    private let uid: String
    
    let userService: UserService = UserService()
    
    init(_ uid: String){
        self.uid = uid
    }
    
    func getUserDoc() async {
        printD("Fetching Doc for: \(uid)")
        do {
            self.user = try await userService.fetchUser(from: uid)

            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 1 second
            withAnimation(.spring()) {
                self.loadingState = user.settings.onboarded ? .user : .noUser
            }
        } catch {
            printD(error.localizedDescription)
            withAnimation(.spring()) {
                loadingState = .noUser
            }
        }
    }
}


struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView("123")
    }
}
