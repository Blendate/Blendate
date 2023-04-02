//
//  ChatView.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ChatView: View {
    @FirestoreQuery(collectionPath: "matches") var messages: [ChatMessage]

    @Binding var withUser: User?
    @State var text: String = ""

    let cid: String
    let author: String
    
    init(author: String, cid: String, with: Binding<User?>){
        self.cid = cid
        self.author = author
        self._withUser = with
    }
    

    var body: some View {
        VStack {
            VStack {
                ChatHeader(user: $withUser)
                ChatBody(messages: messages, withUser: withUser, text: $text)
            }
            ChatTextField(cid: cid, author: author, text: $text)
        }
        .toolbar(.hidden)
        .onAppear{
            $messages.path = CollectionPath.Messages(for: cid)
        }
    }
    
    struct ChatBody: View {
        let messages: [ChatMessage]
        let withUser: User?
        @Binding var text: String
        
        var sorted: [ChatMessage] { messages.sorted{$0.timestamp < $1.timestamp}}
        
        var body: some View {
            if !messages.isEmpty {
                ScrollView {
                    ForEach(sorted) { message in
                        MessageBubble(message, received: message.author == withUser?.id)
                    }
                }
                .padding(.top, 10)
                .background(.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
            } else {
                IceBreakersView(chatText: $text)
            }
        }
    }
    
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(author: aliceUID, cid: conversation.id!, with: .constant(bob))
    }
}
