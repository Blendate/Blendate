//
//  MatchProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct MatchProfileView: View {
    @StateObject var vm: MatchViewModel
    
    var viewUser: User?
    let profileType: ProfileType
    
    init(user: User? = nil){
        self._vm = StateObject(wrappedValue: MatchViewModel())
        if let user = user {
            self.viewUser = user
            self.profileType = .view
        } else {
            self.profileType = .match
        }
    }
    
    var body: some View {
        Group {
            if profileType == .view {
                viewProfile
            } else {
                matchProfile
            }
        }
    }
    
    @ViewBuilder func profileView(_ user: User)->some View {
        ScrollView(showsIndicators: false) {
            ProfileCardView(user.details, profileType, user.id)
            bio(user)
            infocards(user)
            PhotosGridView(.constant(user.details.photos))
            interests(user)
        }
    }
    
    var matchProfile: some View {
        LoadingView(showLoading: vm.loading, .Blue, "Filtering for your potential Blends...") {
            if let first = vm.lineup.first {
                    profileView(first)
                    .environmentObject(vm)
                    .sheet(isPresented: $vm.matched) {
                        withAnimation(.spring()) {
                            vm.matched = false
                            vm.lineup.removeFirst()
                        }
                    } content: {
                        MatchedView(show: $vm.matched, user: User(), matchedWith: first)
                            .environmentObject(vm)
                    }
                    .animation(Animation.spring(), value: vm.lineup.first)
            } else {
                EmptyLineupView(sessionUser: .constant(User()))
            }
        }
        .task {
            await vm.getLineup()
        }
    }
    
    var viewProfile: some View {
        Group {
            if let viewUser = viewUser {
                profileView(viewUser)
            } else {
                EmptyView()
            }
        }
    }
    
    func noInfo(_ user: User)->Bool{
        for group in InfoType.allCases {
            if group.show(user.details) {
                return false
            }
        }
        return true
    }
    

}



struct MatchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MatchProfileView()
    }
}


