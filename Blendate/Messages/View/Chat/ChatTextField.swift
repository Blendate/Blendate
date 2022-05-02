//
//  ChatTextField.swift
//  Blendate
//
//  Created by Michael on 4/11/22.
//

import SwiftUI

struct ChatTextField: View {
    @Binding var newMessage: String
    var send: () async -> Void
    
    var body: some View {
        TextEditorView(string: $newMessage, send: send)
        .padding(.leading, 10)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.LightGray)

    }
}

struct TextEditorView: View {
    
    @Binding var string: String
    var send: () async -> Void

    @State var textEditorHeight : CGFloat = 20
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            Text(string)
                .font(.system(.body))
                .foregroundColor(.clear)
                .padding(14)
                .background(GeometryReader {
                    Color.clear.preference(key: ViewHeightKey.self,
                                           value: $0.frame(in: .local).size.height)
                })
            HStack(alignment: .bottom) {
                TextEditor(text: $string)
                    .font(.system(.body))
                    .frame(height: max(40,textEditorHeight))
                    .cornerRadius(10.0)
                                .shadow(radius: 1.0)
                AsyncButton(action: sendMessage, label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(10)
                        .foregroundColor(string.isBlank ? Color.gray:Color.white)
                        .background(string.isBlank ? Color.clear:Color.Blue)
                        .clipShape(Circle())
                }).disabled(string.isBlank)
            }
            
        }.onPreferenceChange(ViewHeightKey.self) { textEditorHeight = $0 }
        
    }
    
    private func sendMessage() async {
        await send()
        string = ""
    }
    struct ViewHeightKey: PreferenceKey {
        static var defaultValue: CGFloat { 0 }
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = value + nextValue()
        }
    }
}




struct ChatTextField_Previews: PreviewProvider {
    static var previews: some View {
        ChatTextField(newMessage: .constant("New Message")){
            
        }
    }
}
