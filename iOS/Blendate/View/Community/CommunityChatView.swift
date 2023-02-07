//
//  CommunityChatView.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct CommunityChatView: View {
    @EnvironmentObject var session: SessionViewModel
    @StateObject var model: ChatViewModel<CommunityTopic>

    
    init(topic: CommunityTopic) {
        self._model = StateObject(wrappedValue: ChatViewModel(topic))
    }
    
    var uid: String { session.uid }
    
    var body: some View {
        VStack {
            ScrollView {
                header
                ForEach(model.fetched) { message in
                    HStack(spacing: 0) {
                        if message.author != uid {
                            Circle().fill(Color.Blue).frame(width: 40)
                                .padding(.leading)
                        }
                        MessageBubble(message, received: message.author != uid)
                    }
                }
            }
            .padding(.top, 10)
            .background(.white)
            .cornerRadius(30, corners: [.topLeft, .topRight])
//            ChatTextField(newMessage: $model.text, send: model.sendMessage)
        }
    }
    
    var header: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(model.conversation.title)
                    .fontType(.semibold, .largeTitle, .DarkBlue)
                Text(model.conversation.subtitle)
                    .foregroundColor(.DarkBlue)
            }
            Spacer()
            Button(systemName: "bell.circle") {
                
            }
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.DarkBlue)
            
        }.padding(.horizontal)
    }
}

struct CommunityChatView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityChatView(topic: topic)
    }

    static let topic = CommunityTopic(author: dev.michael.id!, title: "Travel Tips & Tricks", subtitle: "Single Mom gives advice on how to travel with kids")
}
