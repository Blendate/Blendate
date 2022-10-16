//
//  MatchProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct MatchProfileView: View {
    @EnvironmentObject var vm: MatchViewModel
    @EnvironmentObject var session: SessionViewModel
    
    var body: some View {
        Group {
            if let first = vm.lineup.first {
                ScrollView(showsIndicators: false) {
                    ProfileCardView(first.details, .match) { swipe in
                        vm.swipe(on: first.id, swipe)
                    }
                    ProfileBio(bio: first.details.bio)
                    InfoCards(details: first.details)
                    PhotosGridView(first.details.photos)
                    TagCloudView(tags: first.details.interests)
                }
                .sheet(isPresented: $vm.matched, onDismiss: nextLineup) {
                    MatchedView(show: $vm.matched, user: session.user, matchedWith: first)
                        .environmentObject(vm)
                }
            } else {
                EmptyLineupView(sessionUser: $session.user)
            }
        }
    }
    
    private func nextLineup(){
        withAnimation(.spring()) {
            vm.matched = false
            vm.lineup.removeFirst()
        }
    }

}

struct ViewProfileView: View {
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ProfileCardView(user.details, .view)
            ProfileBio(bio: user.details.bio)
            InfoCards(details: user.details)
            PhotosGridView(user.details.photos)
            TagCloudView(tags: user.details.interests)
                .padding(.horizontal)
        }
    }
}


struct MatchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MatchProfileView()
            .environmentObject(MatchViewModel())
            .environmentObject(SessionViewModel(dev.tyler.id!))
    }
}


