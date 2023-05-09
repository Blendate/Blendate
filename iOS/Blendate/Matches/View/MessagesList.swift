//
//  MessagesList.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/11/23.
//

import SwiftUI

struct MessagesList: View {
    let author: String
    let conversations: [Match]
    
    var body: some View {
        VStack {
            header
            if !conversations.isEmpty {
                List {
                    ForEach(conversations, id: \.id) { conversation in
                        MatchCell(match: conversation, author: author)
                    }
                }
                .listStyle(.plain)
            } else {
                EmptyMatchs(conversations)
            }
        }
    }
    
    var header: some View {
        HStack {
            Text("Messages")
                .font(.title3.weight(.semibold), .DarkBlue)
            Spacer()
        }
        .padding(.leading)
    }
}

struct MessagesList_Previews: PreviewProvider {
    static var previews: some View {
        MessagesList(author: aliceUID, conversations: [match])
        MessagesList(author: aliceUID, conversations: [])
    }
}
