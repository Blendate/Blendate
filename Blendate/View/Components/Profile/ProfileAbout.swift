//
//  ProfileAbout.swift
//  Blendate
//
//  Created by Michael on 8/8/21.
//

import SwiftUI

struct ProfileAbout: View {
    
    @Binding var userPref: UserPreferences?
    
    
    var body: some View {
        VStack(alignment:.leading){
            if !(userPref?.bio.isEmpty ?? false) {
                VStack {
                    HStack {
                        Text("About \(userPref?.firstName ?? "Name")")
                            .lexendDeca(.regular, 18)
                            .padding()
                        Spacer()
                    }
                    Text(userPref?.bio ?? "")
                        .lexendDeca(.regular, 16)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.Blue)
                        .padding([.horizontal, .bottom])
                        .fixedSize(horizontal: false, vertical: true)
                }
                .background(RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white)
                                .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5))
            }
        }.padding()
    }
}

struct ProfileAbout_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAbout(userPref: .constant(nil))
    }
}
