//
//  ConvoCellView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

struct ConvoCellView: View {
    let conversation: Match
    @State var details: User?
    @EnvironmentObject var session: SessionViewModel

    var body: some View {
        
        if let cid = conversation.id {
            NavigationLink {
                ChatView(cid, with: $details)
            } label: {
                HStack(spacing: 0){
                    PhotoView.MatchAvatar(match: conversation, details: $details)
                    VStack(alignment: .leading) {
                        Text(details?.firstname ?? "")
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
        }
    }
    
}

struct ConvoCellView_Previews: PreviewProvider {
    static var previews: some View {
        ConvoCellView(conversation: dev.conversation)
    }
}
