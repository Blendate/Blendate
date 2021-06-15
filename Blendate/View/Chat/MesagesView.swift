//
//  MesagesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import SwiftUI

struct MessagesView: View {
    
    @Binding var user: User
    
    
    init(_ user: Binding<User>){
        self._user = user
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("New Matches")
                .bold()
                .font(.system(size: 22))
                .foregroundColor(Color("Blue"))
            Text("You currently have no new matches. Start Swiping!")
                .font(.system(size: 14))
            Spacer()
            Text("Messages")
                .bold()
                .font(.system(size: 22))
                .foregroundColor(Color("Blue"))
            Divider()
            MessageCell(inboxMessage: InboxMessage(id: UUID(), lastMessage: "Before you start making connections", name: "Team Blendate", type: "", date: 1.2, userId: "", avatarUrl: ""))
            Spacer()
        }.padding()
    }
    
}

struct MessageCell: View {
    let inboxMessage: InboxMessage
    
    var body: some View {
        HStack{
            Circle().frame(width: 50, height: 50).foregroundColor(.red)
            VStack(alignment: .leading){
                HStack {
                    Text(inboxMessage.name)
                        .font(.system(size: 16))
                        .bold()
                    Spacer()
//                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: inboxMessage.date), currentDate: Date(), numericDates: true))
//                        .foregroundColor(.gray)
//                        .font(.system(size: 14))
                }
                Text("I really think you would like this place")
                    .font(.system(size: 14))

            }
        }.padding(.vertical, 15)
    }
}
