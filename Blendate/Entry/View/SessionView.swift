//
//  SessionView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct SessionView: View {
    @StateObject var vm: SessionViewModel
    
    init(_ uid: String){
        self._vm = StateObject(wrappedValue: SessionViewModel(uid))
    }
    
    var body: some View {
        LoadingView(showLoading: $vm.showLoading) {
            if vm.loadingState == .noUser {
                SignupView(user: $vm.user)
                    .environmentObject(vm)
            } else if vm.loadingState == .user {
                if vm.user.settings.dev?.classicTab ?? false {
                    ClassicTabBar($vm.user, $vm.selectedTab)
                    .task {
                        await vm.requestAuthorizationForNotifications()
                    }
                } else {
                    SessionTabsView($vm.user, $vm.selectedTab)
                    .task {
                        await vm.requestAuthorizationForNotifications()
                    }
                }
            }
        }
        .task {
            await vm.getUserDoc()
        }
    }

}


struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView("123")
    }
}
