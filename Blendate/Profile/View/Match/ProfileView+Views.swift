//
//  ProfileView+Functions.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI

extension MatchProfileView {
    
    @ViewBuilder
    func bio(_ user: User) -> some View {
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
    
    @ViewBuilder
    func infocards(_ user:User) -> some View {
        let details = user.details
        if !noInfo(user) {
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
    
    private func noInfo(_ user: User)->Bool{
        for group in InfoType.allCases {
            if group.show(user.details) {
                return false
            }
        }
        return true
    }
    
    @ViewBuilder
    func interests(_ user: User) -> some View {
        let columns = [
            GridItem(.fixed(getRect().width * 0.425)),
            GridItem(.fixed(getRect().width * 0.425))

        ]
        LazyVGrid(columns: columns, spacing: 5){
            ForEach(user.details.interests, id:\.self){ title in
                Text(title)
                    .fontType(.bold, 16, .white)
                    .padding()
                    .background(Color.Blue)
                    .cornerRadius(20)
            }
        }.padding()
    }
}

