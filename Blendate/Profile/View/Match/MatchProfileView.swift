//
//  MatchProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

enum ProfileType { case view, match, session }
struct MatchProfileView: View {
    @EnvironmentObject var vm: MatchViewModel
    @EnvironmentObject var session: SessionViewModel
    var viewUser: User?
    let profileType: ProfileType
    
    init(user: User? = nil){
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
            PhotosGridView(user.details.photos)
            interests(user)
        }
    }
    
    var matchProfile: some View {
        Group {
            if let first = vm.lineup.first {
                    profileView(first)
                    .environmentObject(vm)
                    .sheet(isPresented: $vm.matched) {
                        withAnimation(.spring()) {
                            vm.matched = false
                            vm.lineup.removeFirst()
                        }
                    } content: {
                        MatchedView(show: $vm.matched, user: session.user, matchedWith: first)
                            .environmentObject(vm)
                    }
                    .animation(Animation.spring(), value: vm.lineup.first)
            } else {
                EmptyLineupView(sessionUser: $session.user)
            }
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
        MatchProfileView(user: dev.michael)
    }
}


