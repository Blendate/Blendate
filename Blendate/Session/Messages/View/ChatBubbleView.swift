//
//  ChatBubbleView.swift
//  Blendate
//
//  Created by Michael on 4/11/22.
//

import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage
    let sessionUID: String
    
    init(_ message: ChatMessage){
        self.message = message
        self.sessionUID = FirebaseManager.instance.auth.currentUser?.uid ?? ""
    }
    
    var body: some View {
        let myMessage = message.author == sessionUID
        let color = myMessage ? Color.Blue:Color.LightGray2
        HStack {
            if myMessage {
                Spacer()
            }
            HStack {
                Text(message.text)
                    .foregroundColor(myMessage ? .white:.black)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(color)
            .cornerRadius(8)
            if !myMessage {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
struct ChatBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubbleView(dev.convo.chats.first!)
    }
}
