//
//  ChatView2.swift
//  Blendate
//
//  Created by Michael on 7/6/21.
//

import SwiftUI

struct ChatView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: ChatViewModel
    @State var showProfile = false
    let withUser: User?
    
    init(_ conversation: Conversation, _ withUser: User? = nil){
        self._vm = StateObject(wrappedValue: ChatViewModel(convo: conversation))
        self.withUser = withUser
    }
    
    var body: some View {
        VStack {
            checkView
            ChatTextField(newMessage: $vm.text, send: sendMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button {
                    if withUser != nil {
                        showProfile = true
                    }
                } label: {
                    Text(withUser?.details.firstname ?? "")
                        .fontType(.bold, 18, .DarkBlue)
                        .padding(.bottom, 8)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                }, label: {
                    VStack(spacing: 4) {
                        Circle()
                            .frame(width: 6, height: 6)
                        Circle()
                            .frame(width: 6, height: 6)
                    }
                })
            }
        }
        .sheet(isPresented: $showProfile) {
            if let user = withUser {
                ProfileView(.constant(user), .view)
            }
        }
    }

    var checkView: some View {
        Group {
            if vm.chatMessages.isEmpty {
                NoChatsView(noChats: $vm.chatMessages, chatText: $vm.text)
            } else {
                chatList
            }
        }
    }
    
    var chatList: some View {
        ScrollView {
            ScrollViewReader { scrollProxy in
                VStack {
                    ForEach(vm.chatMessages, id: \.self.timestamp){ chat in
                        ChatBubbleView(chat)
                    }
                    HStack {Spacer()}
                    .id("Empty")
                }
                .onReceive(vm.$count) { _ in
                    withAnimation(.easeOut(duration: 0.5)){
                        scrollProxy.scrollTo("Empty", anchor: .bottom)
                    }
                }
            }
        }
        .padding(.top,4)
    }

    private func sendMessage() {
        vm.sendMessageCollection()
    }
}



struct ChatView2_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(dev.convo)
        }
    }
}





struct NoChatsView: View {
    @State var icebreaker = Icebreakers.allCases.randomElement()!
    @Binding var noChats: [ChatMessage]
    @Binding var chatText: String
    
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack {
            Spacer()
            Image(icebreaker.rawValue)
            Text(icebreaker.title)
                .fontType(.semibold, 28)
                .foregroundColor(.DarkBlue)
            Spacer()
        }
        .onTapGesture {
            chatText = icebreaker.text
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                var new = Icebreakers.allCases.randomElement()!
                while new == icebreaker {
                    new = Icebreakers.allCases.randomElement()!
                }
                icebreaker = new
            }
        }
    }
}
