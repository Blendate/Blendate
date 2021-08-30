//
//  SaveConversationButton.swift
//  Blendate
//
//  Created by Michael on 8/7/21.
//

import SwiftUI
import RealmSwift

struct SaveConversationButton: View {

    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    

    let members: [String]
    var done: () -> Void = { }
    
    
    var body: some View {
        Button(action: saveConversation, label: {
            Text("Send Message")
                .foregroundColor(.white)
                .frame(width: getRect().width * 0.45, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Capsule()
                                .fill(Color.Blue)
                                .shadow(color: Color(#colorLiteral(red: 0.3446457386, green: 0.3975973725, blue: 0.9629618526, alpha: 0.2406952713)), radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 5))
                .offset(y:getRect().height * 0.175)
        })
    }
    
    private func saveConversation() {
        state.error = nil
        let conversation = Conversation()
        guard let identifier = state.user?.identifier else {
            state.error = "Current user is not set"
            return
        }
        conversation.members.append(Member(identifier: identifier, state: .active))
        conversation.members.append(objectsIn: members.map { Member($0) })
//        state.shouldIndicateActivity = true
        do {
            try userRealm.write {
                state.user?.conversations.append(conversation)
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
//            state.shouldIndicateActivity = false
            return
        }
//        state.shouldIndicateActivity = false
        done()
    }
}

