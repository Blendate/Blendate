//
//  ConvoCellView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

struct ConvoCellView: View {
    let conversation: Conversation
    @State var details: User?
    @EnvironmentObject var session: SessionViewModel

    var body: some View {
        
        NavigationLink {
            ChatView(conversation, with: $details)
        } label: {
            HStack(spacing: 0){
                PhotoView.Avatar(url: details?.photos[0].url, size: 75, isCell: true)
                VStack(alignment: .leading) {
                    Text(details?.firstname ?? "")
                        .fontType(.semibold, .title3)
                        .foregroundColor(.DarkBlue)
                    Text(conversation.lastMessage.text)
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
        guard let withUID = conversation.withUserID(session.uid) else {return}
        self.details = try? await UserService().fetch(fid: withUID)
    }
}

struct ConvoCellView_Previews: PreviewProvider {
    static var previews: some View {
        ConvoCellView(conversation: dev.conversation)
    }
}
