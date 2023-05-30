//
//  MessagesView.swift
//  Blendate
//
//  Created by Michael on 12/9/21.
//

import SwiftUI
import FirebaseFirestoreSwift


struct MatchesView: View {
    @FirestoreQuery(collectionPath: "matches") var matches: [Match]
    @FirestoreQuery(collectionPath: "like_you") var likedYou: [Swipe]
    @FirestoreQuery(collectionPath: "superlike_you") var superLikedYou: [Swipe]
    
    let uid: String
    
    private var allLikes: [Swipe] { likedYou + superLikedYou }

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
                    EmptyContentView(text: matches.isEmpty ? String.EmptyMatches : String.EmptyMessages, svg: "Interested")
                }
            }
            .onAppear{
                if $matches.predicates.isEmpty {
                    $matches.predicates = [.where(field: "users", arrayContains: uid)]
                }
                $likedYou.path = CollectionPath.Path(swipeYou: .like, uid: uid)
                $superLikedYou.path = CollectionPath.Path(swipeYou: .superLike, uid: uid)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: matches) { newValue in
            print(matches.count)
        }
        
    }
//    init(uid: String){
//        self.uid = uid
//        self._matches = FirestoreQuery(collectionPath: CollectionPath.Matches, predicates: [.where(field: "users", arrayContains: uid) ])
//        self._likedYou = FirestoreQuery(collectionPath: CollectionPath.Path(swipeYou: .like, uid: uid))
//        self._superLikedYou = FirestoreQuery(collectionPath: CollectionPath.Path(swipeYou: .superLike, uid: uid))
//    }
}


struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                VStack{
                    MatchesList(uid: aliceUID, matches: [match], likedYou: likedUser)
                    MessagesList(author: aliceUID, conversations: [conversation])
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            NavigationStack {
                VStack{
                    MatchesList(uid: aliceUID, matches: [], likedYou: likedUser)
                    MessagesList(author: aliceUID, conversations: [conversation])
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .previewDisplayName("No Matches")
            NavigationStack {
                VStack{
                    MatchesList(uid: aliceUID, matches: [match], likedYou: likedUser)
                    MessagesList(author: aliceUID, conversations: [])
                    Spacer()
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .previewDisplayName("No Conversations")
            MatchesView(uid: aliceUID)
                .previewDisplayName("Empty")

        }
        .environmentObject(NavigationManager())
        .environmentObject(StoreManager())
    }
}
