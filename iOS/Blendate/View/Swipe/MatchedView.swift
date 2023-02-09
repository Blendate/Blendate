//
//  MatchedView.swift
//  Blendate
//
//  Created by Michael on 1/20/22.
//

import SwiftUI

struct MatchedView: View {
    @Environment(\.dismiss) private var dismiss
    
    let circleSize: CGFloat = 200
    let imageSize: CGFloat = 150
    @State var showChat = false
    var details: User
    var matchedWith: User
    let newConvo: Match

    var body: some View {
        NavigationStack {
            VStack{
                VStack(spacing: 15) {
                    Text("It's A Blend!")
                        .opacity(0.2)
                    Text("It's A Blend!")
                        .opacity(0.4)
                    Text("It's A Blend!")
                }
                .fontType(.regular, 42, .white)
                VStack(spacing: 0) {
                    HStack{
                        userCircle
                        Spacer()
                    }
                    .padding(.horizontal,50)
                    .padding()
                    HStack {
                        Spacer()
                        matchedCircle
                    }.padding(.horizontal, 50)
                }
                if let newConvo = newConvo, let cid = newConvo.id {
                    NavigationLink {
                        ChatView(cid, with: .constant(matchedWith))
                            .padding(.top)
                    } label: {
                        Text("Start Chatting")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.Blue)
                            .cornerRadius(16)
                        
                    }
                }
                Spacer()
            }
            .background(bottom: false)
        }
    }

    var userCircle: some View {
        ZStack{
            Circle()
                .stroke(Color.DarkBlue, lineWidth: 8)
                .frame(width: circleSize, height: circleSize)
                .shadow(radius: 10)
            PhotoView.Avatar(url: details.avatar, size: imageSize)
//                            Circle()
//                                .frame(width: imageSize, height: imageSize)
                .shadow(radius: 5)
        }
    }
    
    var matchedCircle: some View {
        ZStack {
            Circle()
                .stroke(Color.DarkPink, lineWidth: 8)
                .frame(width: circleSize, height: circleSize)
                .offset(y: -60)
                .shadow(radius: 5)

            PhotoView.Avatar(url: matchedWith.avatar, size: imageSize)
//                                .frame(width: imageSize, height: imageSize)
                .offset(y: -60)
                .shadow(radius: 10)

        }
    }

}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView(details: dev.michael, matchedWith: dev.michael, newConvo: dev.conversation)
    }
}
