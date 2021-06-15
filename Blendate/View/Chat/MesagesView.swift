//
//  MesagesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import SwiftUI

struct MessagesView: View {
    @Binding var user: User
    
    @ObservedObject var Vm: MessagesViewModel
    
    
    init(_ user: Binding<User>){
        self._user = user
        self.Vm = MessagesViewModel(user)
    }
    
    var body: some View {
        NavigationView {
            VStack(){
                newBlends
                seperator
                messages
                Spacer()
            }.padding()
        }
    }
    
    var seperator: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(.DarkBlue)
    }
    
    var messages: some View {
        NavigationLink(
            destination: ChatView(Dummy.inbox),
            label: {
                MessageCell(inboxMessage: Dummy.inbox)
            })
    }
    
    var newBlends: some View {
        VStack(alignment: .center, spacing: 50) {
            Text("New Blends")
                .font(.system(size: 28))
                .foregroundColor(.DarkBlue)
            if Vm.inboxMessages.count > 0 {
                
            } else {
                Text("You currently have no new Blends. Start Blending!")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            Text("Messages")
                .font(.system(size: 28))
                .foregroundColor(.DarkBlue)

        }
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
                        .foregroundColor(.black)
                    Spacer()
                }
                Text("Before you start making connections")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)

            }
        }.padding(.vertical, 15)
    }
}


//                    Text(timeAgoSinceDate(Date(timeIntervalSince1970: inboxMessage.date), currentDate: Date(), numericDates: true))
//                        .foregroundColor(.gray)
//                        .font(.system(size: 14))

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView(.constant(Dummy.user))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")

        MessagesView(.constant(Dummy.user))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
    }
}
