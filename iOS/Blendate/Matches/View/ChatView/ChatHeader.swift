//
//  ChatHeader.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI

struct ChatHeader: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var user: User?
    @State private var showProfile = false
    
    var name: String { user?.details.firstname ?? "Name" }
    
    var body: some View {
        HStack(spacing: 15) {
            Button(systemName: "chevron.left"){ dismiss() }
                .font(.title3)
                .foregroundColor(.white)
            Title
            ReportButton(uid: user?.id, name: user?.details.firstname,
                         messageEnd: "Only report chats that do not meet our chat requirements") {
                
            }
            .padding(10)
            .clipShape(Circle())
        }
        .padding()
        .background(Color.Blue)
        .sheet(isPresented: $showProfile) {
            if let user {
                ViewProfileView(user: user)
            }
        }
    }
    
    var Title: some View {
        Button(action: { showProfile.toggle() }) {
            HStack(spacing: 10) {
                image
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.title2).bold()
                        .foregroundColor(.white)
                        .fixedSize()
                    Text("Online")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 6)
            }
        }
    }
    
    var image: some View {
        AsyncImage(url: user?.details.avatar) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
        } placeholder: {
            Circle().fill(Color.Blue)
                .frame(width: 50, height: 50)
        }
    }

}

struct ChatHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeader(user: .constant(bob))
            .previewDisplayName("ChatHeader")
            .background(Color.Blue)
            .previewLayout(.sizeThatFits)

    }
}
