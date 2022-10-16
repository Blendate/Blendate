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
            ChatView(match, with: $user)
        } label: {
            VStack {
                ZStack{
                    Circle()
                        .stroke( Color.DarkBlue,lineWidth: 2)
                        .frame(width: 80, height: 80, alignment: .center)
                    PhotoView.Avatar(request: user?.details.photos[0].request, size: 70, isCell: true)
                }
                Text(user?.details.firstname ?? "")
            }
        }
        .buttonStyle(.plain)
        .task {
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
