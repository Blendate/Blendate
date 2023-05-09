//
//  ProfileButtonLong.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/9/23.
//

import SwiftUI

struct ProfileButtonLong: View {
    let title: String
    var subtitle: String?
    var systemImage: String?
    var color: Color = .Blue
    var showChevron: Bool = true
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if !showChevron {
                    Spacer()
                }
                image
                Text(title)
                    .fontWeight(.semibold)
                    .padding(.leading, 6)
                Spacer()
                if let subtitle {
                    Text(subtitle)
                }
                if showChevron {
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.white)
            .padding(.leading, 8)
        }
        .font(.title3)
        .padding()
        .background(color)
        .cornerRadius(12)
    }
    
    @ViewBuilder
    var image: some View {
        if let systemImage {
            Image(systemName: systemImage)
                .resizable()
                .frame(width: 30, height: 30)
        } else {
            Image.Icon(size: 30, .white)
        }
    }
}

struct ProfileButtonLong_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButtonLong(title: "Membership") {}
    }
}
