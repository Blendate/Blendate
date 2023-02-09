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
                    PhotoView.Avatar(url: details?.avatar, size: 75, isCell: true)
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
            .task {
                await fetchUser()
            }
        }
    }
    
    func fetchUser() async {
        guard let withUID = conversation.withUserID(session.uid) else {return}
        let details = try? await session.fetch(fid: withUID)
        self.details = details
    }
}

struct ConvoCellView_Previews: PreviewProvider {
    static var previews: some View {
        ConvoCellView(conversation: dev.conversation)
    }
}
