//
//  MessagesView.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import FirebaseFirestoreSwift


struct MatchesView: TabItemView {
    @FirestoreQuery(collectionPath: "matches") var matches: [Match]

    let uid: String
    let allLikes: [Swipe]
    
    var remainingLikes: [Swipe] {
        var connections: [String] {
            matches.compactMap { FireStore.withUserID($0.users, uid) }
        }
        return allLikes.filter{!connections.contains($0.id ?? "")}
    }

    var matched: [Match] {
        matches.filter{!$0.conversation}
        .sorted{$0.timestamp > $1.timestamp}
    }
    
    var conversations: [Match] {
        matches.filter{$0.conversation}
        .sorted{($0.lastMessage?.timestamp ?? $0.timestamp) > ($1.lastMessage?.timestamp ?? $1.timestamp)}
    }
    
    
    var body: some View {
        NavigationView {
            Group {
                if !matches.isEmpty || !allLikes.isEmpty {
                    VStack{
                        MatchesList(uid: uid, matches: matched, likedYou: remainingLikes)
                        MessagesList(author: uid, conversations: conversations)
                        Spacer()
                    }
                } else {
                    EmptyMatchs(matches)
                }
            }
            .onAppear{
                if $matches.predicates.isEmpty {
                    $matches.predicates = [.where(field: "users", arrayContains: uid)]
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image.Icon(size:40, .Blue)
                }
            }
        }
        .tag( Self.TabItem )
        .tabItem{ Self.TabItem.image }
        .onChange(of: matches) { newValue in
            print(matches.count)
        }
        
    }
}

struct EmptyMatchs: View {
    let matches: [Match]
    init(_ matches: [Match]) {
        self.matches = matches
    }
    let NoMatchs = "Tap on any of your matches to start a conversation"
    let NoMatches = "Start matching with profiles to blend with others and start conversations"
    var message: String { matches.isEmpty ? NoMatches : NoMatchs }
    
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
                    .font(.semibold, .DarkBlue)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                Spacer()
            }
        }
        .navigationTitle("Blends")
    }
}



struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchesView(uid: aliceUID, allLikes: likedUser)
            MatchesView(uid: aliceUID, allLikes: [])
        }
        .environmentObject(session)
    }
}
