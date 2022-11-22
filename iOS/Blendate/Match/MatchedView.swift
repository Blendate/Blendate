//
//  MatchedView.swift
//  Blendate
//
//  Created by Michael on 1/20/22.
//

import SwiftUI

struct MatchedView: View {
    @Environment(\.dismiss) private var dismiss
//    @EnvironmentObject var vm: MatchViewModel
    
    let circleSize: CGFloat = 200
    let imageSize: CGFloat = 150
    @State var showChat = false
//    @Binding var show: Bool
    var details: Details
    var matchedWith: Details
    let newConvo: Conversation

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
                .fontType(.regular, 42, .Blue)
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
                if let newConvo = newConvo {
                    NavigationLink {
                        ChatView(newConvo, with: .constant(matchedWith))
                            .padding(.top)
                    } label: {
                        Text("Start Chatting")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.Blue)
                    }
                }

//                Button("Start Chatting"){
//                    withAnimation(.spring()) {
//                        showChat = true
//                    }
//                }
//                .fontType(.semibold, 22)
//                .tint(.Blue)
//                .buttonStyle(.borderedProminent)
//                .buttonBorderShape(.capsule)
//                .controlSize(.large)
                Spacer()
            }
        }
    }

    var userCircle: some View {
        let userPhoto = details.photos.first(where: {$0.placement == 0})?.request

        return ZStack{
            Circle()
                .stroke(Color.DarkBlue, lineWidth: 8)
                .frame(width: circleSize, height: circleSize)
                .shadow(radius: 10)
            PhotoView.Avatar(request: userPhoto, size: imageSize, isCell: true)
//                            Circle()
//                                .frame(width: imageSize, height: imageSize)
                .shadow(radius: 5)
        }
    }
    
    var matchedCircle: some View {
        let matchedWithPhoto = matchedWith.photos.first(where: {$0.placement == 0})?.request
        return ZStack {
            Circle()
                .stroke(Color.DarkPink, lineWidth: 8)
                .frame(width: circleSize, height: circleSize)
                .offset(y: -60)
                .shadow(radius: 5)

            PhotoView.Avatar(request: matchedWithPhoto, size: imageSize, isCell: true)
//                                .frame(width: imageSize, height: imageSize)
                .offset(y: -60)
                .shadow(radius: 10)

        }
    }

}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView(details: dev.details, matchedWith: dev.details, newConvo: dev.convo)
    }
}
