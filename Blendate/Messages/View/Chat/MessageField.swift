//
//  MessageField.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct MessageField: View {
    @Binding var message: String
    
    var body: some View {
        HStack {
            CustomTextField(placeholder: Text("Send a Message"), text: $message)
            Button(action: {message = ""}) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.Blue)
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color.LightGray2)
        .cornerRadius(50)
        .padding()
    }
    
    struct CustomTextField: View {
        var placeholder: Text
        @Binding var text: String
        var editingChanged: (Bool) -> () = {_ in}
        var commit: () -> () = {}
        
        var body: some View {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    placeholder
                        .opacity(0.5)
                }
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
            }
        }
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField(message: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}
