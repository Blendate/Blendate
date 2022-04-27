//
//  ConversationsView.swift
//  Blendate
//
//  Created by Michael on 2/11/22.
//

import SwiftUI

struct ConversationsView: View {
    var conversations: [Conversation]
    
    init(_ convos: [Conversation]){
        self.conversations = convos
    }

    
    var body: some View {
        Group {
            if conversations.isEmpty {
                noConvos
            } else {
                VStack {
                    messageDivider
                    List {
                        ForEach(conversations, id: \.id) { conversation in
                            ConvoCellView(conversation: conversation)
                        }
                    }.listStyle(.plain)
                }
            }
        }
    }
    
    var noConvos: some View {
        VStack{
            Divider()
            Image("Interested")
                .resizable()
                .scaledToFill()
                .frame(width: 270, height: 226 , alignment: .center)
            Text("Tap on any of your matches to start a conversation")
                .fontType(.regular, 18, .DarkBlue)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top)
            Spacer()
        }
    }
    
    var messageDivider: some View {
        VStack(spacing:0){
            HStack{
                Text("Messages")
                    .fontType(.bold, 28, .DarkBlue)
                    .padding(.bottom, 4)
                Spacer()
            }.padding(.leading)
            Rectangle()
                .fill(Color.DarkBlue)
                .frame(width: getRect().width * 0.9, height: 1)
        }.padding(.bottom, 10)
    }
}

struct ConvoCellView: View {
//    @EnvironmentObject var vm: MessagesViewModel
    var conversation: Conversation
    @State var user: User?

    var body: some View {
        
        NavigationLink {
            ChatView(conversation, user)
        } label: {
            HStack{
                AvatarView(url: user?.details.photos[0].url, size: 64)
                VStack(alignment: .leading) {
                    Text(user?.details.firstname ?? "")
                        .fontType(.semibold, 16)
                        .foregroundColor(.DarkBlue)
                    Text(conversation.lastMessage.prefix(25) + "...")
                        .fontType(.semibold, 16)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }.padding(.leading)
                Spacer()
            }
        }
        .task {
            await fetchUser()
        }
    }
    
    func fetchUser() async {
        guard let withUID = conversation.withUserID(FirebaseManager.instance.auth.currentUser?.uid) else {return}
        self.user = try? await FirebaseManager.instance.Users
            .document(withUID)
            .getDocument()
            .data(as: User.self)
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView([])
    }
}
