//
//  ProfileView+Functions.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI

extension ProfileView {
    
    var bio: some View {
        Group {
            let bio = user.details.bio
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
    
    var infocards: some View {
        Group {
            let details = user.details
            if !noInfo() {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top) {
                        ForEach(InfoType.allCases){ type in
                            if type.show(details){
                                InfoCard(type, details)
                            }
                        }
                    }.padding()
                }
            }
        }
    }
    
    var interests: some View {
        let columns = [GridItem(.adaptive(minimum: getRect().width * 0.425), spacing: 10)]
        return LazyVGrid(columns: columns, spacing: 10){
            ForEach(user.details.interests, id:\.self){ title in
                ZStack{
                    RoundedRectangle(cornerRadius: 25.0)
                        .fill(Color.white)
                        .frame(width: getRect().width * 0.45, height: 90, alignment: .center)
                    VStack{
                        Text(title)
                            .fontType(.bold, 16)
                            .foregroundColor(.Blue)

                    }
                    .frame(width: getRect().width * 0.425, height: 85, alignment: .center)
                }
            }
        }.padding()
    }
}

struct ProfileView_Views_Previews: PreviewProvider {
    static let profile = ProfileView(.constant(dev.michael), .session)
    static var previews: some View {
        profile.bio
            .previewLayout(.sizeThatFits)
        profile.infocards
            .previewLayout(.sizeThatFits)
        profile.interests
            .previewLayout(.sizeThatFits)
    }
}

