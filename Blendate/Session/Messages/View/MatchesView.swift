//
//  MatchesView.swift
//  Blendate
//
//  Created by Michael on 2/11/22.
//

import SwiftUI

struct MatchesView: View {
    var matches: [Conversation]
        
    init(_ matches: [Conversation]){
        self.matches = matches
    }
    
    var body: some View {
        if matches.isEmpty { emptyMatches }
        else {
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack(spacing: 20){
                    ForEach(matches, id:\.self.timestamp){ match in
                        MatchAvatarView(match)
                    }
                }
                .padding(.leading)
            }
            .frame(height: 120, alignment: .center)
            .padding(.leading)
        }
    }
    
    var emptyMatches: some View {
        Text("Match with profiles to Blend with others")
            .fontType(.regular, 18, .DarkBlue)
            .frame(height: 120, alignment: .center)
            .padding(.horizontal)
    }
}


struct MatchAvatarView: View {
    var match: Conversation
    @State var startConvo = false
    @State var user: User?

    init(_ match: Conversation){
        self.match = match
    }

    var body: some View {
        NavigationLink {
            ChatView(match, user)
        } label: {
            VStack {
                ZStack{
                    Circle()
                        .stroke( Color.DarkBlue,lineWidth: 2)
                        .frame(width: 80, height: 80, alignment: .center)
                    AvatarView(url: user?.details.photos[0].url, size: 70)
                }
                Text(user?.details.firstname ?? "")
            }
        }.task {
            await fetchUser()
        }
    }
    
    func fetchUser() async {
        guard let withUID = match.withUserID(FirebaseManager.instance.auth.currentUser?.uid) else {return}
        self.user = try? await FirebaseManager.instance.Users
            .document(withUID)
            .getDocument()
            .data(as: User.self)
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView([])
    }
}
