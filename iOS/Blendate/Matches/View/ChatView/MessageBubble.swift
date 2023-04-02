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
    var backgroundColor: Color { received ? Color.LightGray6 : Color.Blue }
    var textColor: Color { received ? .black : .white }
    
    var body: some View {
        VStack(alignment: received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding(.horizontal)
                    .padding(.vertical,12)
                    .background(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: 300, alignment: alignment)
            .onTapGesture { withAnimation(.spring()) { showTime.toggle() } }
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
        MessageBubble(message, received: true)
            .previewLayout(.sizeThatFits)
        MessageBubble(longMessage, received: true)
            .previewLayout(.sizeThatFits)
        ChatView.ChatBody(messages: [message, longMessage], withUser: bob, text: .constant(""))

        
    }
}
