//
//  ChatView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 4/5/21.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var chatArray: [Chat] = Dummy.chats
    @State var text: String = ""
    let inbox: InboxMessage
    
    func sendMessage() {

    }
    
    init(_ inbox: InboxMessage){
        self.inbox = inbox
    }
        
    var body: some View {
        VStack {
            topBar
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0.5) {
                    ForEach(chatArray, id: \.messageId) { chat in
                        ChatBubble(chat)
                    }
                }
            }.padding(.bottom)
             .background(Color.white)
             .cornerRadius(40, corners: [.topLeft, .topRight])
            MessageTextView(sendMessage: sendMessage,fullText: $text)
                .background(Color.white)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .background(Color.LightGray.edgesIgnoringSafeArea(.all))
    }
    
    var topBar: some View {
        HStack {
            Button(action: {self.presentationMode.wrappedValue.dismiss()}, label: {
                Image(systemName: "chevron.left")
            })
            Circle()
                .frame(width: 50, height: 50)
                .padding()
//            circle(.blue)
            Text(inbox.name)
                .bold()
            Spacer()
            Image(systemName: "ellipsis")
        }
        .padding(.horizontal)
    }
}

    

struct MessageTextView: View {
    
    var sendMessage: ()-> Void
    @Binding var fullText: String
    
    var body: some View {
        HStack {
            TextField("Message", text: $fullText)
                .frame(width: UIScreen.main.bounds.width - 80)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: sendMessage) {
                Image(systemName: "paperplane")
                    .foregroundColor(fullText.count == 0 ? .gray : .Blue)
            }.disabled(fullText.count == 0)
        }.padding()
        .background(Color.LightGray2)
    }
    
}


struct ChatBubble: View {
    enum Direction {
        case left
        case right
    }
    
    let chat: Chat
    let direction: Direction

    init(_ chat: Chat){
        self.chat = chat
        self.direction = Int(chat.messageId)! % 2 == 0 ? .right : .left
    }
    
    var body: some View {
        HStack {
            if direction == .right { Spacer() }
            Text(chat.text)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(direction == .right ? Color.gray:.Blue)
                .foregroundColor(direction == .right ? .black:.white)
                .clipShape(Capsule())
            if direction == .left { Spacer() }
        }.padding([(direction == .left) ? .leading : .trailing, .top, .bottom], 20)
        .padding((direction == .right) ? .leading : .trailing, 50)
    }
}


struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(Dummy.inbox)
    }
}
