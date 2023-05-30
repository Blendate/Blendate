//
//  SwipeProfileView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct SwipeProfileView: View {
    @AppStorage("firstLaunch3") var firstLaunch: Bool = true

    @EnvironmentObject var session: UserViewModel
    @EnvironmentObject var navigation: NavigationManager
    
    @StateObject var model: SwipeViewModel
    
    @State private var error: (any ErrorAlert)?
    
    public var user: User? = nil

    private var showing: User? { user ?? model.presenting }
    private var superLiked: Bool { false }
    
    var body: some View {
        Group {
            if firstLaunch {
                aliceView
                    .task {
                        await model.fetchLineup(for: session.user)
                    }
            } else if let _ = showing {
                swipeView
            } else if model.loading {
                LaunchView()
                    .task {
                        await model.fetchLineup(for: session.user)
                    }
            } else {
                EmptyContentView(text: String.NoProfileFilters)
            }
        }

    }
    
    var aliceView: some View {
        ViewProfileView(user: User.Alice) {
            MatchButtons { swipe in
                withAnimation {
                    firstLaunch = false
                }
            }
        }
    }
    
    @ViewBuilder
    var swipeView: some View {
        if let showing {
            ViewProfileView (
                user: showing,
                superLikedYou: superLiked,
                reported: model.nextLineup,
                buttons: MatchButtons(swiped: swiped)
            )
            .sheet(item: $model.match, onDismiss: model.nextLineup) {
                MatchedView(with: showing, match: $0)
            }
            .errorAlert(error: $error) { error in
                if error is Swipe.SuperLike {
                    Button("Purchase") {
                        navigation.showPurchaseLikes = true
                    }
                } else if error is Swipe.Error {
                    Button("Try again") {
                        session.save()
                    }
                }
                Button("Cancel", role: .cancel){}
            }
        }
    }
    

    private func swiped(_ swipe: Swipe.Action) {
        do {
            try model.swipe(swipe, on: showing, superLikes: session.settings.premium.superLikes)
            if swipe == .superLike {
                session.settings.premium.superLikes -= 1
                session.save()
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
        Group {
            SwipeProfileView(model: .init(bobUID))
                .previewDisplayName("Empty")
            SwipeProfileView(model: .init(bobUID, presenting: alice))
                .previewDisplayName("Presenting")
        }
            .environmentObject(session)
            .environmentObject(NavigationManager())
    }
}
