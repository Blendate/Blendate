//
//  ChatTextField.swift
//  Blendate
//
//  Created by Michael on 8/7/21.
//

import SwiftUI

struct ChatTextField: View {
    @EnvironmentObject var state: AppState
    
    var send: (_: ChatMessage) -> Void = { _ in }
    @State var newMessage: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                
                .frame(width: getRect().width , height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            HStack {
                HStack{
                    TextField("Type your message", text: $newMessage)
                    Button(action: sendChat, label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.gray)
                    })
                }.padding()
                .background(Capsule().fill(Color(#colorLiteral(red: 0.9490118623, green: 0.9489287734, blue: 0.9575280547, alpha: 1))))
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .padding(.horizontal)
        }
    }
    
    private func sendChat() {
        sendMessage(text: newMessage)
        newMessage = ""
    }
    
    private func sendMessage(text: String) {
            let chatMessage = ChatMessage(
                author: state.user?.identifier ?? "Unknown",
                text: text
            )
            send(chatMessage)
    }
}
