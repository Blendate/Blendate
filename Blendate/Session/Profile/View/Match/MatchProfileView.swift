//
//  MatchProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct MatchProfileView: View {
    @StateObject var vm: MatchViewModel

    @Binding var sessionUser: User
    
    init(sessionUser: Binding<User>){
        self._vm = StateObject(wrappedValue: MatchViewModel())
        self._sessionUser = sessionUser
    }
    
    var body: some View {
        LoadingView(showLoading: $vm.loading, .Blue, "Filtering for your potential Blends...") {
            if let first = vm.lineup.first {
                ProfileView(.constant(first), .match)
                    .environmentObject(vm)
                    .sheet(isPresented: $vm.matched) {
                        withAnimation(.spring()) {
                            vm.matched = false
                            vm.lineup.removeFirst()
                        }
                    } content: {
                        MatchedView(show: $vm.matched, user: sessionUser, matchedWith: first)
                            .environmentObject(vm)
                    }
                    .animation(Animation.spring(), value: vm.lineup.first)
            } else {
                EmptyLineupView(sessionUser: $sessionUser)
            }
        }
        .task {
            await vm.getLineup()
        }
    }
}



struct MatchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MatchProfileView(sessionUser: .constant(dev.michael))
    }
}


