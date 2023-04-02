//
//  PremiumButton.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/13/23.
//

import SwiftUI

struct PremiumButton: View {
    let isMembership: Bool
    var title: String { isMembership ? "Premium Membership" : "Get more Super Likes"}
    var tapped: ()->Void
    
    var color: Color { isMembership ? Color.Blue : Color.Purple }
    var body: some View {
        Button {
            tapped()
        } label: {
            HStack {
                image
                    .foregroundColor(color)
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                Text(title)
                    .font(.title2.weight(.semibold), .white)
                    .padding(.leading, 6)
                Spacer()

            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(isMembership ? Color.Purple : Color.Blue)
            .cornerRadius(16)
        }

    }
    
    var image: some View {
        Group {
            if isMembership {
                Image.Icon(size: 25)
            } else {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
    }
}



struct PremiumButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PremiumButton(isMembership: true){}
            PremiumButton(isMembership: false){}

        }
    }
}
