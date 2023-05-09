//
//  ProfileBioView.swift
//  Blendate
//
//  Created by Michael on 11/29/22.
//

import SwiftUI

struct ProfileBioView: View {
    let bio: Bio
    
    var body: some View {
        if !(bio.rawValue.isEmpty) {
            Text(bio.rawValue)
                .foregroundColor(.DarkBlue)
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

struct ProfileBioView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBioView(bio: alice.bio)
    }
}
