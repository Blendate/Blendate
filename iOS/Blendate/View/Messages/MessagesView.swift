//
//  MessagesView.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import MapKit

struct MessagesView: View {
    @StateObject var model: MessagesViewModel
    @EnvironmentObject var session: SessionViewModel
    @EnvironmentObject var match: MatchViewModel
    
    init(uid: String){
        self._model = StateObject(wrappedValue: MessagesViewModel(uid: uid))
    }
    
    var body: some View {
        NavigationView {
            Group {
                if model.fetched.isEmpty {
                    EmptyConversations(model.fetched)
                } else {
                    VStack{
                        Matches(matches: model.matches)
                        Messages(conversations: model.conversations)
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image.icon(40).foregroundColor(.Blue)
                }
            }
        }
    }
    

}

extension MessagesView {
    struct Matches: View {
        @EnvironmentObject var premium: SettingsViewModel
        @EnvironmentObject var session: SessionViewModel
        
        var matches: [Conversation]
        var body: some View {
            VStack {
                if matches.isEmpty {
                    emptyMatches
                }
                else {
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 15){
                            likedYou
                            ForEach(matches){ match in
                                MatchAvatarView(match)
                            }
                        }
                        .padding(.leading)
                    }
                    .frame(height: 120, alignment: .center)
                    .padding(.leading)
                }
            }.padding(.vertical)
        }
        
        var emptyMatches: some View {
            HStack(alignment: .top) {
                likedYou
                Text("Match with profiles to Blend with others")
                    .fontType(.semibold, 18, .DarkBlue)
                Spacer()
            }.padding(.leading)
        }
        
        var firstLike: String? {
            matches.first?.users.first{$0 != session.uid}
        }
        
        var likedYou: some View {
            Button {
                if premium.hasPremium {
                    session.selectedTab = .likes
                } else {
                    premium.showMembership = true
                }
            } label: {
                ZStack {
                    Circle()
                        .stroke( Color.DarkBlue,lineWidth: 2)
                        .frame(width: 80, height: 80, alignment: .center)
                    if let firstLike {
                        PhotoView.Avatar(url: URL(string: firstLike), size: 70, isCell: true)
                            .blur(radius: premium.hasPremium ? 0 : 20)
                            .clipShape(Circle())
                    } else {
                        Circle().fill(Color.Blue)
                            .frame(width: 70, height: 70)
                    }


                    VStack(spacing: 0) {
                        Text("10")
                        Text("Likes")
                    }
                    .fontType(.semibold, .body, .white)
                }
            }

        }
    }

}

extension MessagesView {
    
    struct Messages: View {
        var conversations: [Conversation]
        
        var body: some View {
            VStack {
                HStack {
                    Text("Messages")
                        .fontType(.bold, .title3, .DarkBlue)
                        .padding(.leading)
                    Spacer()
                }
                if conversations.isEmpty {
                    EmptyConversations(conversations)
                } else {
                    List {
                        ForEach(conversations, id: \.id) { conversation in
                            ConvoCellView(conversation: conversation)
                        }
                    }.listStyle(.plain)
                }
            }
        }
    }
    
    struct EmptyConversations: View {
        let conversations: [Conversation]
        init(_ conversations: [Conversation]) {
            self.conversations = conversations
        }
        let NoConversations = "Tap on any of your matches to start a conversation"
        let NoMatches = "Start matching with profiles to blend with others and start conversations"
        var message: String { conversations.isEmpty ? NoMatches : NoConversations }
        
        var body: some View {
            VStack {
                Spacer()
                VStack{
                    Divider()
                    Image("Interested")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 270, height: 226 , alignment: .center)
                    Text(message)
                        .fontType(.semibold, 18, .DarkBlue)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    Spacer()
                }
            }
            .navigationTitle("Blends")
        }
    }



}


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(uid: dev.tyler.id!)
    }
}
