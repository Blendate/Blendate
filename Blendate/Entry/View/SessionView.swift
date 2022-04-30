//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

enum SessionState {case noUser, user, loading}

struct SessionView: View {
    @StateObject var vm: SessionViewModel
    
    init(_ uid: String){
        self._vm = StateObject(wrappedValue: SessionViewModel(uid))
    }
    
    var body: some View {
        LoadingView(showLoading: vm.loadingState == .loading) {
            if vm.loadingState == .noUser {
                SignupView(user: $vm.user)
                    .environmentObject(vm)
            } else if vm.loadingState == .user {
                tabBar
            }
        }
        .task {
            await vm.getUserDoc()
        }
    }
    
    @ViewBuilder
    var tabBar: some View {
        if vm.user.settings.dev?.classicTab ?? false {
            ClassicTabBar($vm.user, $vm.selectedTab)
        } else {
            SessionTabsView($vm.user, $vm.selectedTab)

        }
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
