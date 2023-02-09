//
//  MatchProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct SwipeProfileView: View {
    @EnvironmentObject var model: SwipeViewModel
    @EnvironmentObject var match: MatchesViewModel
    @EnvironmentObject var session: SessionViewModel
    @EnvironmentObject var settings: SettingsViewModel

    @State var newConvo: Match?
    
    var user: User?
    
    var showing: User? { user ?? model.showing}
    
    var body: some View {
        if let details = showing, let withUID = details.id {
            ScrollView(showsIndicators: false) {
                ProfileCardView(details: details, type: .match) { await swiped(on: withUID, $0) }
                InfoCardsView(details: details)
                ProfileBioView(bio: details.bio)
                PhotosGridView(details.photos)
                TagCloudView(tags: details.interests)
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(item: $newConvo, onDismiss: nextLineup) { convo in
                MatchedView(details: session.user, matchedWith: details, newConvo: convo)
            }
        } else {
            EmptyLineupView()
        }
    }

    private func swiped(on uid: String, _ swipe: Swipe) async {
        let matched = await model.swipe(on: uid, swipe)
        if matched {
            do {
                let conversation = try self.match.create(with: uid)
                if swipe == .superLike { settings.useSuperLike() }
                self.newConvo = conversation
            } catch {
                model.alert = AlertError(title: "Server Error", message: "Could not create your match on the Blendate server.")
            }
        } else {
            nextLineup()
        }

    }
    
    private func nextLineup() {
        withAnimation {
            self.newConvo = nil
            model.lineup.removeFirst()
            model.showing = model.lineup.first
        }
    }

}

struct ViewProfileView: View {
    let details: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ProfileCardView(details:details, type: .view)
            InfoCardsView(details: details)
            ProfileBioView(bio: details.bio)
            PhotosGridView(details.photos)
            TagCloudView(tags: details.interests)
        }
    }
}



struct MatchProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeProfileView()
            .environmentObject(SwipeViewModel(dev.tyler.id!, lineup: [dev.michael]))
            .environmentObject(SessionViewModel(dev.tyler.id!))
            .environmentObject(MatchesViewModel(dev.tyler.id!))
            .environmentObject(SettingsViewModel(dev.tyler.id!))

    }
}


