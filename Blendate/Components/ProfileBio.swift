//
//  ProfileBio.swift
//  Blendate
//
//  Created by Michael on 9/29/22.
//

import SwiftUI

struct ProfileBio: View {
    let bio: String
    
    var body: some View {
        if !(bio.isEmpty) {
            Text(bio)
                .fontType(.regular, 16, .DarkBlue)
                .multilineTextAlignment(.leading)
                .padding()
                .fixedSize(horizontal: false, vertical: true)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5)
                .padding(.horizontal)
        }
    }
}

struct ProfileBio_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBio(bio: dev.tyler.details.bio)
    }
}
