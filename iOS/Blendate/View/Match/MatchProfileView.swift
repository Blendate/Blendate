//
//  MatchProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct MatchProfileView: View {
    @EnvironmentObject var model: SwipeViewModel
    @EnvironmentObject var session: SessionViewModel
    
    @State var newConvo: Match?
    
    var user: User? = nil
    
    var body: some View {
        if let details = model.lineup.first {
            ScrollView(showsIndicators: false) {
                ProfileCardView(details, .match) { await swiped(details, $0) }
                ProfileBioView(bio: details.bio)
                InfoCardsView(details: details)
                PhotosGridView(details.photos)
                TagCloudView(tags: details.interests)
            }
            .sheet(item: $newConvo, onDismiss: nextLineup) { convo in
                MatchedView(details: session.user, matchedWith: details, newConvo: convo)
            }
        } else {
            EmptyLineupView()
        }
    }

    private func swiped(_ details: User, _ swipe: Swipe) async {
        guard let match = details.id else {return}
        let matched = await model.swipe(on: match, swipe)
        if swipe == .superLike { session.useSuperLike() }
        if matched {
            let conversation = Match(user1: session.uid, user2: match)
            do {
                let cid = try MatchesViewModel(uid: session.uid).create(conversation)
                conversation.id = cid
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
            .environmentObject(SwipeViewModel(dev.tyler.id!))
            .environmentObject(SessionViewModel(dev.tyler.id!))
    }
}


