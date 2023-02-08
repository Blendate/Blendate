//
//  ChatView.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct ChatView: View {
    @EnvironmentObject var session: SessionViewModel
    @StateObject var model: ChatViewModel<Match>
    @Binding var withUser: User?

    init(_ convo: Match, with: Binding<User?>){
        self._model = StateObject(wrappedValue: ChatViewModel(convo))
        self._withUser = with
    }
    
    var sorted: [ChatMessage] { model.fetched.sorted{$0.timestamp < $1.timestamp}}
    
    var body: some View {
        VStack {
            VStack {
                ChatHeader(details: $withUser)
                    .background(Color.Blue)
                if !model.fetched.isEmpty {
                    ScrollView {
                        ForEach(sorted) { message in
                            MessageBubble(message, received: message.author == withUser?.id)
                        }
                    }
                    .padding(.top, 10)
                    .background(.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                } else {
                    IceBreakersView(noChats: $model.fetched, chatText: $model.text)
                }
            }
            ChatTextField(newMessage: $model.text) {
                model.sendMessage(author: session.uid)
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
