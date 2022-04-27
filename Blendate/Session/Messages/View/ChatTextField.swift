//
//  ChatTextField.swift
//  Blendate
//
//  Created by Michael on 4/11/22.
//

import SwiftUI

struct ChatTextField: View {
    @Binding var newMessage: String
    var send: () -> Void
    @State var height:CGFloat = 60
    
    var body: some View {
        HStack {
            TextEditor(text: $newMessage)
                .cornerRadius(8)
                .padding(.leading, 10)
//            Button {
//                sendMessage()
//            } label: {
//                Text("Send")
//                    .foregroundColor(.white)
//
//            }
//            .padding(.horizontal)
//            .padding(.vertical, 8)
//            .background(Color.DarkBlue)
//            .cornerRadius(4)
//            .disabled(newMessage.isBlank)
            Button(action: sendMessage, label: {
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(10)
                    .foregroundColor(newMessage.isBlank ? Color.gray:Color.white)
                    .background(newMessage.isBlank ? Color.clear:Color.Blue)
                    .clipShape(Circle())
//                    .padding(.trailing, 10)
            }).disabled(newMessage.isBlank)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .frame(height: height)
        .background(Color.LightGray)

    }
        
    private func sendMessage() {
        send()
        newMessage = ""
    }
}

struct ChatTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChatTextField(newMessage: .constant("New Message")){
            
        }
    }
}
