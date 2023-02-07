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
    @EnvironmentObject var premium: SettingsViewModel
    
    var user: User? = nil
    
    var body: some View {
        if let details = vm.lineup.first {
            ScrollView(showsIndicators: false) {
                ProfileCardView(details, .match) { await swiped(details, $0) }
                ProfileBioView(bio: details.bio)
                InfoCardsView(details: details)
                PhotosGridView(details.photos)
                TagCloudView(tags: details.interests)
            }
            .sheet(item: $vm.newConvo, onDismiss: nextLineup) { convo in
                MatchedView(details: session.user, matchedWith: details, newConvo: convo)
            }
        } else {
            EmptyLineupView()
        }
    }

    private func swiped(_ details: User, _ swipe: Swipe) async {
        guard let match = details.id else {return}
        let matched = await vm.swipe(on: match, swipe)
        if swipe == .superLike { premium.useSuperLike() }
        if matched {
            await vm.createConvo(with: match)
        } else {
            nextLineup()
        }

    }
    
    private func nextLineup() {
        withAnimation {
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
            ProfileBioView(bio: details.bio)
            InfoCardsView(details: details)
            PhotosGridView(details.photos)
            TagCloudView(tags: details.interests)
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


