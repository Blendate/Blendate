//
//  TodayBlendView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI

struct TodayBlendView: View {
    
    let user: User
    
    var body: some View {
        ZStack {
            ColorGradient.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Today's Blend")
                    .bold()
                    .blendFont(36, .white)
                    .padding()
                Circle()
                    .foregroundColor(.green)
                    .frame(width: 174, height: 174)
                    .padding(25)
                    .overlay(
                        Circle()
                            .stroke(Color.white, lineWidth: 6)
                    )
                Text(user.fullName() + ", \(user.age())")
                    .blendFont(28, .white)
                    .padding(.top)
                HStack {
                    Button(action:{}){
                        HStack {
                            Image("noMatch")
                                .foregroundColor(.red)
                            Text("DISMISS")
                                .foregroundColor(.red)
                        }.padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .clipShape(Capsule())
                    }
                    Button(action:{}){
                        HStack {
                            Image("icon")
                                .foregroundColor(Color.Pink)
                            Text("BLEND")
                                .foregroundColor(Color.Pink)
                        }.padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .clipShape(Capsule())
                    }
                }.padding()
            }
        }
    }
}

struct TodayBlendView_Previews: PreviewProvider {
    static var previews: some View {
        TodayBlendView(user: Dummy.user)
    }
}
