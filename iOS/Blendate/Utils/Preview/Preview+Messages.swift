//
//  Preview+Messages.swift
//  Blendate
//
//  Created by Michael on 5/30/23.
//

import SwiftUI

extension PreviewProvider {
    static var match: Match {
        let match = Match(aliceUID, bobUID)
        match.id = FireStore.getUsersID(userId1: aliceUID, userId2: bobUID)
        return match
    }
    
    static var conversation: Match {
        let conversation = Match(aliceUID, bobUID, lastMessage: longMessage)
        conversation.id = FireStore.getUsersID(userId1: aliceUID, userId2: bobUID)
        return conversation
    }
    static var message: ChatMessage {
        var message = ChatMessage(author: aliceUID, text: "Hello Bob!")
        message.id = "56789"
        return message
    }
    static var longMessage: ChatMessage {
        var long = ChatMessage(author: bobUID, text: String(String.LoremIpsum.prefix(140)))
        long.id = "1234"
        return long
    }
}
