//
//  DevPreview.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    
    static var aliceUID: String { "y0ovvAPls7cthTLKmiDGZJEUfD23" }
    static var bobUID: String { "sjZMzfqjrkgP3MAFcutG5Fc9aqI3" }
    static var charlieUID: String { "8ndZMzfqjr3282380MAFcuc9aqf94" }
    
    static var session: UserViewModel { UserViewModel(uid: aliceUID, user: alice, settings: .init() ) }

    static var likedUser: [Swipe] { [Swipe(.like)] }
    static var userLikes: [Swipe] { [Swipe(.like)] }


}

struct PreviewViewModifier<MyView:View>: ViewModifier {

//struct PreviewModifier<Content:View>: ViewModifier {
    
    let size: CGSize
    let content: MyView
    let title: String?

    
    func body(content: Content) -> some View {
        ZStack {
            if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
                ZStack {
                    Text(title ?? "Preview Blocked")
                }
                .frame(width: size.width, height: size.height)
                .background(Color.LightGray5)
            } else {
                content
            }
        }
    }
}

extension View {
        
    @ViewBuilder
    func isPreview<C:View>(_ size: CGSize, content: C) -> some View {
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            ZStack {
                Text("Preview Blocked")
            }
            .frame(width: size.width, height: size.height)
            .background(Color.LightGray5)
        } else {
            content
        }
    }
}


extension View {
    func noPreview(_ width: Int = 25, _ height: Int = 25, _ title: String? = nil) -> some View {
        let size = CGSize(width: width, height: height)
        return modifier(PreviewViewModifier(size: size, content: self, title: title))
    }
}
