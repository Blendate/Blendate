//
//  DevPreview.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var preview: DevPreviewProvider { DevPreviewProvider.dev }
    static var aliceUID: String { preview.uid }
    static var bobUID: String { preview.uid2 }
    static var alice: User { preview.alice }
    static var bob: User { preview.bob }
    
    static var settings: User.Settings { preview.settings}
    
    static var conversation: Match { preview.conversation }
    static var match: Match { preview.match }
    static var message: ChatMessage { preview.message }
    static var longMessage: ChatMessage { preview.longMessage }
    
    static var session: UserViewModel { preview.session }
    static var swipeModel: SwipeViewModel { preview.swipeModel }

    static var likedUser: [Swipe] { [Swipe(.like)] }
    static var userLikes: [Swipe] { [Swipe(.like)] }


}

class DevPreviewProvider {
    static let dev = DevPreviewProvider()
    private init(){
        //        FirebaseApp.configure()
    }
    
    var uid: String { "y0ovvAPls7cthTLKmiDGZJEUfD23" }
    var uid2: String { "sjZMzfqjrkgP3MAFcutG5Fc9aqI3" }
    var uid3: String { "1234" }
    
    var settings: User.Settings {
        var settings = User.Settings()
        settings.id = uid
        return settings
    }
    
    var bobSettings: User.Settings {
        var settings = User.Settings()
        settings.id = uid2
        return settings
    }
    
    var alice: User {
        let user = User()
        user.id = uid
        user.details = details
        user.filters = filters
        user.info = info
        return user
    }
    
    var bob: User {
        let user = User()
        user.id = uid2
        user.details = bob_details
        user.filters = filters
        user.info = info
        return user
    }
    
    var charlie: User {
        let user = User()
        user.id = uid3
        return user
    }
    
    var longMessage: ChatMessage {
        var long = ChatMessage(author: uid, text: String(String.LoremIpsum.prefix(140)))
        long.id = "1234"
        return long
    }
        
    var message: ChatMessage {
        var message = ChatMessage(author: uid, text: "Hello Bob!")
        message.id = "56789"
        return message
        
    }
    
    var conversation: Match {
        let match = Match(uid, uid2, lastMessage: message)
        match.id = FireStore.getUsersID(userId1: uid, userId2: uid2)
        return match
    }
    
    var match: Match {
        let match = Match(uid, uid2)
        match.id = FireStore.getUsersID(userId1: uid, userId2: uid2)
        return match
    }
    var session: UserViewModel { UserViewModel(user: alice) }
    var onboardinSession: UserViewModel { UserViewModel(user: alice, state: .onboarding) }
    var swipeModel: SwipeViewModel { SwipeViewModel(uid, presenting: bob) }
}


struct PreviewSignup: View {

    let path: SignupPath
    let dev = DevPreviewProvider.dev

    var body: some View {
        SignupView(dev.uid)
            .environmentObject(dev.session)
    }
}

extension UserViewModel {
    convenience init(user: User, state: SessionState = .user) {
        self.init(user.id!)
        self.user = user
        self.state = state
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
