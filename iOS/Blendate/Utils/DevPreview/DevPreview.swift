//
//  DevPreview.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}
class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    private init() { }
    
    var empty: User {
        return User(id: "12345", settings: UserSettings(), fcm: "")
    }
    var michael:User = DeveloperPreview.michael_
    
    var profilesheet = ProfileSheet()
    
    @StateObject var session = SessionViewModel(user: DeveloperPreview.michael_)
    
    var conversation: Conversation { Conversation(id: "1234", users: ["1234", ""], lastMessage: longChatMessage, timestamp: Date() ) }
    let chatmessage = ChatMessage(author: "1234", text: "Testing a short message")
    let longChatMessage = ChatMessage(author: "", text: String(lorem.prefix(140)))

    static let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    @State var bindingMichael = michael_
    
    @ViewBuilder
    func signup(_ detail: Detail) -> some View {
        PreviewSignup(detail)
    }
    
}

extension SessionViewModel {
    convenience init(user: User) {
        self.init(user.id ?? "")
        self.user = user
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
            .background(Color.LightGray)
        } else {
            content
        }
    }
}

struct PreviewSignup: View {

    let type: Detail

    init(_ type: Detail){
        self.type = type
    }
    var body: some View {
        NavigationView {
            PropertyView(type, signup: true)
        }
    }
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
                .background(Color.LightGray)
            } else {
                content
            }
        }
    }
}


extension View {
    func noPreview(_ width: Int = 25, _ height: Int = 25, _ title: String? = nil) -> some View {
        let size = CGSize(width: width, height: height)
        return modifier(PreviewViewModifier(size: size, content: self, title: title))
    }
}

public func printD(_ object: Any){
    #if DEBUG
    let line = "--------------------------------------"
    let newLine = ""
    
    Swift.print(line + newLine)
    Swift.print(object)
    Swift.print(newLine + line)
    
    #endif
}
