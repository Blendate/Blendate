//
//  ChatView2.swift
//  Blendate
//
//  Created by Michael on 7/6/21.
//

import SwiftUI
import RealmSwift

struct ChatView2: View {
    @ObservedResults(ChatMessage.self, sortDescriptor: SortDescriptor(keyPath: "timestamp", ascending: true)) var chats
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var state: AppState
    
    let conversation: Conversation?
        
    @State private var realmChatsNotificationToken: NotificationToken?
    @State private var latestChatId = ""
    
    let matchUser: MatchUser
    
    init(_ conversation: Conversation?, _ matchUser: MatchUser){
        self.conversation = conversation
        self.matchUser = matchUser
    }

    
    var body: some View {
        
        VStack{
            ChatBannerView(matchUser: matchUser) {
                self.presentationMode.wrappedValue.dismiss()
            }
            ScrollView{
                matchName
                ForEach(chats){ chat in
                    ChatCellView(chat: chat)
                }
            }
            .background(RoundedRectangle(cornerRadius: 25.0)
                            .fill(Color.white)
                            .shadow(color: Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 10, y: -8))
            .offset(y:10)
            Spacer()
            ChatTextField(send: sendMessage)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear { loadChatRoom() }
        .onDisappear { closeChatRoom() }
    }

    
    private func loadChatRoom() {
        scrollToBottom()
        realmChatsNotificationToken = chats.thaw()?.observe { _ in
            scrollToBottom()
        }
    }
    
    private func closeChatRoom() {
        if let token = realmChatsNotificationToken {
            token.invalidate()
        }
    }
    
    private func sendMessage(chatMessage: ChatMessage) {
        guard let conversataionString = conversation else {
            print("comversation not set")
            return
        }
        chatMessage.conversationId = conversataionString.id
        $chats.append(chatMessage)
    }
    
    private func scrollToBottom() {
        latestChatId = chats.last?._id ?? ""
    }
    
    var matchName: some View {
        HStack {
            Spacer()
            Text("You matched with \(matchUser.userPreferences?.firstName ?? "FirstName") !")
                .foregroundColor(.white)
                .padding(10)
                .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2444113493, green: 0.3430365324, blue: 0.8086824417, alpha: 1)), Color(#colorLiteral(red: 0.6895270944, green: 0.4312193692, blue: 0.8058347106, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                .clipShape(Capsule())
                .padding(.vertical)
            Spacer()
        }
    }
}

struct ChatView2_Previews: PreviewProvider {
    static var previews: some View {
        ChatView2(Conversation(), MatchUser())
    }
}


