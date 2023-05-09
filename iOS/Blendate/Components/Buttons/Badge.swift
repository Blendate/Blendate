//
//  Badge.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/15/23.
//

import SwiftUI

struct Badge: View {
    let count: Int
    
    var color: Color { Swipe.Action.superLike.color }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Text(String(count))
                .font(.largeTitle)
                .padding()
                .background(Color.white)
                .foregroundColor(color)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(color, lineWidth: 2)
                )
            // custom positioning in the top-right corner
                .alignmentGuide(.top) { $0[.bottom] }
                .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.15 }
        }
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(count: 0)
    }
}
