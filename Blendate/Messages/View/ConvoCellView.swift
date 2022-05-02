//
//  ConvoCellView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

struct ConvoCellView: View {
    @Binding var conversation: Conversation
    @State var user: User?

    var body: some View {
        
        NavigationLink {
            ChatView(conversation, user)
        } label: {
            HStack{
                PhotoView.Avatar(request: user?.details.photos[0].request, size: 64, isCell: true)
                VStack(alignment: .leading) {
                    Text(user?.details.firstname ?? "")
                        .fontType(.semibold, 16)
                        .foregroundColor(.DarkBlue)
                    Text(conversation.lastMessage.count < 21 ? conversation.lastMessage:conversation.lastMessage.prefix(20) + "...")
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

struct ConvoCellView_Previews: PreviewProvider {
    static var previews: some View {
        ConvoCellView(conversation: .constant(dev.conversation))
    }
}
