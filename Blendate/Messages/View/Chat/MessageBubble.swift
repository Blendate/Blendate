//
//  MessageBubble.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    let received: Bool
    
    init(_ message: ChatMessage, received: Bool){
        self.message = message
        self.received = received
    }
    
    @State private var showTime = false
    
    var alignment: Alignment { received ? .leading : .trailing }
    var edge: Edge.Set { received ? .leading : .trailing }
    
    var body: some View {
        VStack(alignment: received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background( received ?
                                 Color.LightGray2 : Color.Blue)
                    .cornerRadius(30)
                    .foregroundColor(received ? .black : .white)
            }.frame(maxWidth: 300, alignment: alignment)
            .onTapGesture {
                showTime.toggle()
            }
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(edge)
                
            }
        }
        .frame(maxWidth: .infinity, alignment: alignment)
        .padding(edge)
    }
    
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(dev.chatmessage, received: true)
            .previewDisplayName("ChatBubble")
            .previewLayout(.sizeThatFits)
//        MessageBubble(dev.longChatMessage, received: false)
//            .previewDisplayName("ChatBubble2")
//            .previewLayout(.sizeThatFits)
        
    }
}
