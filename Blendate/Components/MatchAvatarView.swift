//
//  MatchAvatarView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

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


struct MatchAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        MatchAvatarView(dev.conversation)
    }
}
