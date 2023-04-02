//
//  SwipeProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct SwipeProfileView: TabItemView {
    @EnvironmentObject var session: UserViewModel
    @EnvironmentObject var model: SwipeViewModel
    @State var error: (any ErrorAlert)?

    var superLiked: Bool {
        let uids = superLikedYou.compactMap{$0.id}
        
        return uids.contains(showing?.id ?? "empty")
    }
    
    ///  user when passed specifically
    var user: User? = nil
    let superLikedYou: [Swipe]

    ///  the first User in the fetched lineup
    private var showing: User? { user ?? model.presenting }
    
    ///  presented when the user is out of SuperLikes
    @State private var purchaseSuperLikes = false
    
    var body: some View {
        Group {
            if let showing = model.presenting {
                ViewProfileView (
                    user: showing,
                    superLikedYou: superLiked,
                    reported: model.nextLineup,
                    buttons: MatchButtons(swiped: swiped)
                )
                .sheet(item: $model.match, onDismiss: model.nextLineup) {
                    MatchedView(with: showing, match: $0)
                }
                .sheet(isPresented: $purchaseSuperLikes){
                    PurchaseLikesView(settings: $session.settings)
                }
                .errorAlert(error: $error) { error in
                    if error is Swipe.SuperLike {
                        Button("Purchase") {
                            purchaseSuperLikes = true
                        }
                        Button("Cancel", role: .cancel){}
                    } else if error is Swipe.Error {
                        Button("Try again") {
                            try? session.saveSettings()
                        }
                        Button("Cancel", role: .cancel){}
                    }

                }
            } else {
                EmptyLineupView(
                    loading: $model.loading,
                    button: FilterButton(user: $session.user, settings: $session.settings)
                )
            }
        }

        .tag(Self.TabItem)
        .tabItem{Self.TabItem.image}
    }
    

    private func swiped(_ swipe: Swipe.Action) {
        do {
            try model.swipe(swipe, on: showing, superLikes: session.settings.premium.superLikes)
            if swipe == .superLike {
                session.settings.premium.superLikes -= 1
                try session.saveSettings()
            }
        } catch let error as ErrorAlert {
            self.error = error
        } catch {
            print(error)
        }

    }
}


struct SwipeProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeProfileView(superLikedYou: [])
            .environmentObject(swipeModel)
            .environmentObject(session)

    }
}
//    match.superLikeYou.contains(details.id ?? "")


