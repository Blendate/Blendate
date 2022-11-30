//
//  SwipeButton.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import SwiftUI

struct SwipeButton: View {
    @EnvironmentObject var premium: PremiumViewModel


    let swipe: Swipe
    var action: (_ swipe: Swipe) -> Void
    
    init(swipe: Swipe, action: @escaping (_ swipe: Swipe) -> Void) {
        self.swipe = swipe
        self.action = action
    }

    var blend: Bool {
        swipe == .like
    }
    var body: some View {
        Button(action: swiped) {
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

    
    private func swiped(){
        if swipe == .superLike && premium.settings.superLikes < 0 {
            DispatchQueue.main.async {
                premium.showSuperLike = true
            }
        } else {
            action(swipe)
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
