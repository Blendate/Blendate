//
//  MatchedView.swift
//  Blendate
//
//  Created by Michael on 1/20/22.
//

import SwiftUI

struct MatchedView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: MatchViewModel
    let circleSize: CGFloat = 200
    let imageSize: CGFloat = 150
    @State var showChat = false
    @Binding var show: Bool
    var user: User
    var matchedWith: User
        
    var body: some View {
        if !showChat {
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
                        ZStack{
                            Circle()
                                .stroke(Color.DarkBlue, lineWidth: 8)
                                .frame(width: circleSize, height: circleSize)
                                .shadow(radius: 10)
                            Circle()
                                .frame(width: imageSize, height: imageSize)
                                .shadow(radius: 5)
                        }
                        Spacer()

                    }.padding(.horizontal,50)
                        .padding()
                    HStack {
                        Spacer()
                        ZStack {
                            Circle()
                                .stroke(Color.DarkPink, lineWidth: 8)
                                .frame(width: circleSize, height: circleSize)
                                .offset(y: -60)
                                .shadow(radius: 5)

                            Circle()
                                .frame(width: imageSize, height: imageSize)
                                .offset(y: -60)
                                .shadow(radius: 10)

                        }
                    }.padding(.horizontal, 50)
                }
                Button("Start Chatting"){
                    showChat = true
                }
                .fontType(.semibold, 22)
                .tint(.purple)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                Spacer()
            }
        } else {
            if !(vm.newConvo.id?.isEmpty ?? true) {
                NavigationView {
                    ChatView(vm.newConvo, matchedWith)
                        .padding(.top)
                }
            }
        }
    }
    

}

struct MatchedView_Previews: PreviewProvider {
    static var previews: some View {
        MatchedView(show: .constant(true), user: dev.michael, matchedWith: dev.tyler)
    }
}
