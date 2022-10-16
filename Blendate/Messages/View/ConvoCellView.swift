//
//  ConvoCellView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

struct ConvoCellView: View {
    let conversation: Conversation
    @State var user: User?

    var body: some View {
        
        NavigationLink {
            ChatView(conversation, with: $user)
        } label: {
            HStack(spacing: 0){
                PhotoView.Avatar(request: user?.details.photos[0].request, size: 75, isCell: true)
                VStack(alignment: .leading) {
                    Text(user?.details.firstname ?? "")
                        .fontType(.semibold, .title3)
                        .foregroundColor(.DarkBlue)
                    Text(conversation.lastMessage)
                        .foregroundColor(.gray)
                        .opacity(0.5)
                }
                .padding(.leading)
                Spacer()
            }
        }
        .buttonStyle(.plain)
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

struct ConvoCellView_Previews: PreviewProvider {
    static var previews: some View {
        ConvoCellView(conversation: dev.conversation)
    }
}
