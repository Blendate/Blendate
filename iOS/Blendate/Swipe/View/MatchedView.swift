//
//  MatchedView.swift
//  Blendate
//
//  Created by Michael on 1/20/22.
//

import SwiftUI

struct MatchedView: View {
    @EnvironmentObject var user: UserViewModel
    @Environment(\.dismiss) private var dismiss
    
    let circleSize: CGFloat = 200
    let imageSize: CGFloat = 150
    @State var showChat = false
    var with: User
    let match: Match

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
                .font(.largeTitle, .white)
                Spacer()
                matchCircle
                Spacer()
                if let mid = match.id,
                    let withID = with.id,
                    let uid = FireStore.withUserID(match.users, withID) {
                    NavigationLink {
                        ChatView(author: uid, cid: mid, with: .constant(with))
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
            .background(text: "", bottom: false)
        }
    }
}

extension MatchedView {
    var matchCircle: some View {
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
    }

    var userCircle: some View {
        ZStack{
            Circle()
                .stroke(Color.DarkBlue, lineWidth: 8)
                .frame(width: circleSize, height: circleSize)
                .shadow(radius: 10)
            PhotoView(avatar: user.user.details.avatar, size: imageSize)
//                            Circle()
//                                .frame(width: imageSize, height: imageSize)
                .shadow(radius: 5)
        }
    }

    var matchedCircle: some View {
        ZStack {
            Circle()
                .stroke(Color.Purple, lineWidth: 8)
                .frame(width: circleSize, height: circleSize)
                .offset(y: -60)
                .shadow(radius: 5)

            PhotoView(avatar: with.details.avatar, size: imageSize)
//                                .frame(width: imageSize, height: imageSize)
                .offset(y: -60)
                .shadow(radius: 10)

        }
    }
}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView(with: bob, match: conversation)
            .environmentObject(UserViewModel(user: alice))
    }
}
