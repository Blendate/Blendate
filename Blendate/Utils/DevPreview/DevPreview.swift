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
    
    var emptyUser: User {
        return User(id: "12345", details: Details(), filters: Filters(.filter), settings: UserSettings(), fcm: "")
    }
    
    var michael: User { DeveloperPreview.michael }
    
    var tyler: User { DeveloperPreview.tyler }
    
    var empty: User {DeveloperPreview.empty}
    
    var convo: Conversation { DeveloperPreview.convo }
    
    var profilesheet = ProfileSheet()
    
    let conversation = Conversation(id: "1234", users: ["1234", "5678"], chats: [], lastMessage: "Message", timestamp: Date() )
    let chatmessage = ChatMessage(author: "1234", text: "Testing a short message")
    
    @State var bindingMichael = michael
    
    @ViewBuilder
    func signup(_ detail: SignupDetail) -> some View {
        PreviewSignup(detail)
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
    
    let type: SignupDetail
    @StateObject var session = SessionViewModel("")
    
    init(_ type: SignupDetail){
        self.type = type
    }
    var body: some View {
        SignupViewPreview(type)
            .environmentObject(session)
            .previewDevice("iPhone 13")
        SignupViewPreview(type)
            .environmentObject(session)
            .previewDevice("iPhone 8")
        SignupViewPreview(type)
            .environmentObject(session)
            .previewDevice("iPhone SE (3rd generation)")

    }
    
    struct SignupViewPreview: View {
        let type: SignupDetail

        init(_ type: SignupDetail){
            self.type = type
        }
        var body: some View {
            NavigationView {
                SignupView(type)
            }
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
    let newLine = "\n\n\n"
    
    Swift.print(line + newLine)
    Swift.print(object)
    Swift.print(newLine + line)
    
    #endif
}
