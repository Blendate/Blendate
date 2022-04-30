//
//  ChatView2.swift
//  Blendate
//
//  Created by Michael on 7/6/21.
//

import SwiftUI

struct ChatView: View {
    @StateObject var vm: ChatViewModel
    @State private var showProfile = false
    
    let withUser: User?
    
    init(_ conversation: Conversation, _ withUser: User? = nil){
        self._vm = StateObject(wrappedValue: ChatViewModel(convo: conversation))
        self.withUser = withUser
    }
    
    var body: some View {
        VStack {
            if !vm.chatMessages.isEmpty {
                ScrollView {
                    ScrollViewReader { scrollProxy in
                        VStack {
                            ForEach(vm.chatMessages, id: \.self.timestamp){ chat in
                                ChatBubbleView(chat)
                            }
                            empty
                        }
                        .onReceive(vm.$count) { _ in
                            withAnimation(.easeOut(duration: 0.5)){
                                scrollProxy.scrollTo("Empty", anchor: .bottom)
                            }
                        }
                    }
                }.padding(.top,4)
            } else {
                IceBreakersView(noChats: $vm.chatMessages, chatText: $vm.text)
            }
            
            ChatTextField(newMessage: $vm.text, send: vm.sendMessage)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                profilebutton
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                actionsbutton
            }
        }
        .sheet(isPresented: $showProfile) {
            if let user = withUser { ProfileView(.constant(user), .view) }
        }
    }
}

extension ChatView {
    var profilebutton: some View {
        Button {
            showProfile = true
        } label: {
            Text(withUser?.details.firstname ?? "")
                .fontType(.bold, 18, .DarkBlue)
                .padding(.bottom, 8)
        }.disabled(withUser == nil)
    }
    
    var actionsbutton: some View {
        Button(action: {}) {
            VStack(spacing: 4) {
                Circle()
                    .frame(width: 6, height: 6)
                Circle()
                    .frame(width: 6, height: 6)
            }
        }
    }
    
    var empty: some View {
        HStack {Spacer()}.id("Empty")
    }
}



struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView(dev.convo)
        }
    }
}


