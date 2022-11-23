//
//  ChatView.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct ChatView: View {
    @StateObject var model: ChatViewModel
    @Binding var withUser: User?

    init(_ convo: Conversation, with: Binding<User?>){
        self._model = StateObject(wrappedValue: ChatViewModel(convo))
        self._withUser = with
    }
    
    var body: some View {
        VStack {
            VStack {
                ChatHeader(details: $withUser)
                    .background(Color.Blue)
                if !model.chatMessages.isEmpty {
                    ScrollView {
                        ForEach(model.chatMessages) { message in
                            MessageBubble(message, received: message.author == withUser?.id)
                        }
                    }
                    .padding(.top, 10)
                    .background(.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                } else {
                    IceBreakersView(noChats: $model.chatMessages, chatText: $model.text)
                }
            }
            ChatTextField(newMessage: $model.text) {
                await model.sendMessage(to: withUser?.id)
            }
//            MessageField(message: $model.text)
        }
        .toolbar(.hidden)
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(dev.conversation, with: .constant(dev.michael))
    }
}
