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
    @State var details: User?
    
    let service = UserService()
    private let uid: String

    init(_ match: Conversation, uid: String){
        self.match = match
        self.uid = uid
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
                Text(" ")
            }
        }
        .buttonStyle(.plain)
        .task {
            await fetchUser()
        }
    }
    
    @MainActor
    func fetchUser() async {
        guard let withUID = match.withUserID(uid) else {return}
        self.details = try? await service.fetch(fid: withUID)

    }
}


struct MatchAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        MatchAvatarView(dev.conversation, uid: dev.tyler.id!)
    }
}
