//
//  CoverPhoto.swift
//  Blendate
//
//  Created by Michael on 8/8/21.
//

import SwiftUI
import RealmSwift

struct ProfileCoverPhoto: View {
    
    @Binding var userPref: UserPreferences?
    
    var body: some View {
        if let picture = userPref?.coverPhoto?.picture,
            let image = UIImage(data: picture) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 250)
        } else {
            Rectangle().foregroundColor(.gray)
                .frame(width: UIScreen.main.bounds.width, height: 250)
        }
    }
}

struct CoverPhoto_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCoverPhoto(userPref: .constant(UserPreferences()))
            .environmentObject(AppState())
    }
}

