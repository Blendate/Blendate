//
//  SwiftUIView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/10/23.
//

import SwiftUI

struct CardView<Title:View,Buttons:View>: View {
    let avatarUrl: URL?
    var avatarSize: CGFloat = 200
    let superLiked: Bool
    @ViewBuilder var title: Title
    @ViewBuilder var buttons: Buttons

    var body: some View {
        ZStack(alignment: .top) {
            Card(avatarSize: avatarSize, superLiked: superLiked, title: title, buttons: buttons)
            PhotoView(avatar: avatarUrl, size: avatarSize)
        }
    }
}

extension CardView {
    struct Card<Title: View, Buttons: View>: View {
        var avatarSize: CGFloat? = nil
        var superLiked: Bool = false
        var title: Title
        var buttons: Buttons
//        var swipe: (_ swipe: Swipe) -> Void = {swipe in}
        
        var color: Color { superLiked ? Color.Purple : Color.Blue }
        var padding: CGFloat { avatarSize ?? 0}
        
        var body: some View {
            VStack(spacing: 0) {
                title
                buttons
                .padding([.bottom, .horizontal])
            }
            .font(.semibold, .white)
            .padding(.top, padding/2)
            .background(color.opacity(0.6))
            .mask(RoundedRectangle(cornerRadius: 25.0))
            .padding(.horizontal)
            .padding(.top, padding/2)
        }
    }
}

extension CardView {

    init(avatarUrl: URL?, avatarSize: CGFloat = 200, superLiked: Bool = false, title: Title, buttons: Buttons) {
        self.avatarSize = avatarSize
        self.superLiked = superLiked
        self.title = title
        self.buttons = buttons
        self.avatarUrl = avatarUrl
    }

    init(avatarUrl: URL?, avatarSize: CGFloat = 200, superLiked: Bool = false, title: Title) where Buttons == HStack<Spacer> {
        let button = HStack {Spacer()}
        self.init(avatarUrl: avatarUrl, avatarSize: avatarSize, superLiked: superLiked, title: title, buttons: button)
    }

}
struct MatchButtons: View {
    var swiped: (_ swipe: Swipe.Action) -> Void

    var body: some View {
        HStack {
            Spacer()
            SwipeButton(swipe: .pass, action: swiped)
            Spacer()
            SwipeButton(swipe: .superLike, action: swiped)
                .padding(.top)
            Spacer()
            SwipeButton(swipe: .like, action: swiped)
            Spacer()
        }
    }
}

//struct Card_Previews: PreviewProvider {
//    static var urlString: String {
//        "https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"
//    }
//    static var previews: some View {
//        CardView(superLiked: true) {
//            Text("Name")
//        } buttons: {
//            HStack{Spacer()}
//        }
//
//    }
//}
