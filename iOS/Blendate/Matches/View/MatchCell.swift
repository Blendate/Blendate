//
//  MatchCell.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/17/23.
//

import SwiftUI

struct MatchCell: View {
    let match: Match
    let author: String
    
    @State var withUser: User? = nil
    
    var body: some View {
        if let cid = match.id {
            NavigationLink {
                ChatView(author: author, cid: cid, with: $withUser)
            } label: {
                if match.conversation {
                    messageCell
                } else {
                    matchCell
                }
            }
            .buttonStyle(.plain)
            .task { await fetchUser() }
        }
    }
    
    var image: some View {
        PhotoView(avatar: withUser?.avatar)
    }
    
    var matchCell: some View {
        ZStack{
            Circle()
                .stroke(  Color.DarkBlue, lineWidth: 2)
                .frame(width: 80, height: 80, alignment: .center)
            image
        }
        .padding(.vertical)
    }
    
    var messageCell: some View {
        HStack(spacing: 0){
            image
            VStack(alignment: .leading) {
                Text(withUser?.firstname ?? "--")
                    .font(.title3.weight(.semibold), .DarkBlue)
                Text(match.lastMessage?.text ?? "")
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
            .padding(.leading)
            Spacer()
        }
    }
    

    
    @MainActor
    func fetchUser() async {
        guard withUser == nil, let withUID = FireStore.withUserID(match.users, author) else {return}
        self.withUser = try? await FireStore.instance.fetch(uid: withUID)
    }
}

struct MatchCell_Previews: PreviewProvider {
    static var previews: some View {
        MatchCell(match: match, author: aliceUID)
    }
}
