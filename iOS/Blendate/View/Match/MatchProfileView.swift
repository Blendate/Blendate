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
    
    @State private var showFilters = false
    
    var body: some View {
        if let first = vm.lineup.first {
            profile(first)
        } else {
            empty
        }
    }
    
    @ViewBuilder
    func profile(_ details: User) -> some View {
        if let first = vm.lineup.first {
            ScrollView(showsIndicators: false) {
                ProfileCardView(details, .match) { swipe in
                    vm.swipe(on: first.id, swipe)
                }
                ProfileBio(bio: details.bio)
                InfoCards(details: details)
                PhotosGridView(details.photos)
                TagCloudView(tags: details.interests)
            }
            .sheet(item: $vm.newConvo) {
                nextLineup()
            } content: { convo in
                MatchedView(details: session.user, matchedWith: first, newConvo: convo)
            }

        }
    }
    
    var empty: some View {
        EmptyLineupView(showFilters: $showFilters)
        .sheet(isPresented: $showFilters) {
            try? session.saveUser()
        } content: {
            NavigationStack {
                FiltersView()
            }
        }
    }

    
    private func nextLineup(){
        withAnimation(.spring()) {
            vm.newConvo = nil
            vm.lineup.removeFirst()
        }
    }

}

struct ViewProfileView: View {
    let details: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ProfileCardView(details, .view)
            ProfileBio(bio: details.bio)
            InfoCards(details: details)
            PhotosGridView(details.photos)
            TagCloudView(tags: details.interests)
                .padding(.horizontal)
        }
    }
}


struct MatchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MatchProfileView()
            .environmentObject(MatchViewModel(dev.tyler.id!))
            .environmentObject(SessionViewModel(dev.tyler.id!))
    }
}


