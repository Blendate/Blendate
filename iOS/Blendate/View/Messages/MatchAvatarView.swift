//
//  MatchAvatarView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

struct MatchAvatarView: View {
    @EnvironmentObject var session: SessionViewModel
    var match: Conversation
    @State var startConvo = false
    @State var details: User?
    
    let service = UserService()

    init(_ match: Conversation){
        self.match = match
    }

    var body: some View {
        NavigationLink {
            ChatView(match, with: $details)
        } label: {
            VStack {
                ZStack{
                    Circle()
                        .stroke( Color.DarkBlue,lineWidth: 2)
                        .frame(width: 80, height: 80, alignment: .center)
                    PhotoView.Avatar(url: details?.avatar, size: 70, isCell: true)
                }
            }
        }
        .buttonStyle(.plain)
        .task {
            await fetchUser()
        }
    }
    
    @MainActor
    func fetchUser() async {
        guard let withUID = match.withUserID(session.uid) else {return}
        self.details = try? await service.fetch(fid: withUID)

    }
}


struct MatchAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        MatchAvatarView(dev.conversation)
            .environmentObject(SessionViewModel(dev.michael.id!))
    }
}
