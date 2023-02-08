//
//  SwipeButton.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import SwiftUI

struct SwipeButton: View {
    @EnvironmentObject var session: SessionViewModel

    let swipe: Swipe
    var action: (_ swipe: Swipe) async -> Void
    
    init(swipe: Swipe, action: @escaping (_ swipe: Swipe) async -> Void) {
        self.swipe = swipe
        self.action = action
    }

    var blend: Bool {
        swipe == .like
    }
    var body: some View {
        AsyncButton(action: swiped) {
            Group {
                if swipe == .superLike {
                    Image(systemName: "star.fill")
                        .renderingMode(.template)
                        .resizable()

                } else {
                    Image(swipe.imageName)
                        .renderingMode(.template)
                        .resizable()
                }

            }
            .foregroundColor(.white)
            .frame(width: blend ? 20:30, height: 30)
            .padding(blend ? 15:10)
            .background(swipe.color)
            .clipShape(Circle())
//                .overlay(
//                    Circle()
//                    .stroke(Color.white, lineWidth: 1)
//                )
        }
    }

    @MainActor
    private func swiped() async {
        if swipe == .superLike && session.settings.superLikes < 0 {
            session.showSuperLike = true
        } else {
            await action(swipe)
        }
    }
}


struct SwipeButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButton(swipe: .like) { swipe in }
        SwipeButton(swipe: .pass) { swipe in }
        SwipeButton(swipe: .superLike) { swipe in }

    }
}
