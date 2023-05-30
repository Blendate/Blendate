//
//  ChatTextField.swift
//  Blendate
//
//  Created by Michael on 4/11/22.
//

import SwiftUI

struct ChatTextField: View {
    let cid: String
    let author: String

    @Binding var text: String
    
    @State private var error: (any ErrorAlert)?
    
    var body: some View {
        HStack(alignment: .bottom) {
            TextField("Something nice", text: $text, axis: .vertical)
                .lineLimit(4)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.LightGray5, lineWidth: 1)
                }
            Button(action: sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.white, Color.Blue)
                    .font(.title.weight(.semibold))
                
            }
            .disabled(text.isBlank)
        }
        .padding()
        .errorAlert(error: $error) { error in
            Button("Try again") {
                sendMessage()
            }
            Button("Cancel", role: .cancel){}
        }
    }
    
    func sendMessage() {
        let chatMessage = ChatMessage(author: author, text: text)
        do {
            try FireStore.shared.sendMessage(chatMessage, to: cid)
            self.text = ""
        } catch let error as ErrorAlert {
            self.error = error
        } catch {
            print("💬⚠️ [ChatTextField][Error] Failed to send message to \(cid)")
        }
    }

}

struct ChatTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChatTextField(cid:"",author:"",text: .constant("Hello World"))
    }
}
