//
//  SwipeButton.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import SwiftUI

struct SwipeButton: View {
    let swipe: Swipe
    var action: (_ swipe: Swipe) async -> Void
    
    var blend: Bool { swipe == .like }
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
            .frame(width: blend ? 25:35, height: 35)
            .padding(blend ? 18:15)
            .background(swipe.color)
            .clipShape(Circle())
        }
    }

    private func swiped() async {
        await action(swipe)
    }
}


struct SwipeButton_Previews: PreviewProvider {
    static var previews: some View {
        SwipeButton(swipe: .like) { swipe in }
        SwipeButton(swipe: .pass) { swipe in }
        SwipeButton(swipe: .superLike) { swipe in }

    }
}
