//
//  ChatHeader.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import SwiftUI
import CachedAsyncImage

struct ChatHeader: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var user: User?
    @State private var showProfile = false
    
    var name: String { user?.details.fullName ?? "Fullname" }
    var url: URL? { user?.details.photos.first{$0.placement == 0}?.url }
    
    var body: some View {
        HStack(spacing: 10) {
            backButton
            title
            button
        }
        .padding()
        .sheet(isPresented: $showProfile) {
            if let user = user {
                ViewProfileView(user: user)
            }
        }
    }
    
    var title: some View {
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
        CachedAsyncImage(url: url) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
        } placeholder: {
            Circle().fill(Color.Blue)
                .frame(width: 50, height: 50)
        }
    }
    
    var backButton: some View {
        Button(systemName: "chevron.left"){
            dismiss()
        }
        .font(.title3)
        .foregroundColor(.white)
    }
    
    var button: some View {
        Button(systemName: "phone.fill") {
                
        }
        .foregroundColor(.gray)
        .padding(10)
        .background(.white)
        .cornerRadius(50)
    }
}

struct ChatHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeader(user: .constant(dev.michael))
            .previewDisplayName("ChatHeader")
            .background(Color.Blue)
            .previewLayout(.sizeThatFits)

    }
}
