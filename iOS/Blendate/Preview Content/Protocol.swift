//
//  Protocol.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/6/23.
//

import Foundation

protocol Service { static var emoji: String { get } }
extension Service {
    
    func print(_ string: String, _ error: Error? = nil){
        let emoji = error != nil ? Self.emoji+"⚠️" : Self.emoji
        let serviceName = String(describing: Self.self)

        let title = "\(emoji) [\(serviceName)] "
        Swift.print(title + string + (error?.localizedDescription ?? ""))
    }
}

extension SessionViewModel: Service { static let emoji = "📱" }
extension SwipeViewModel: Service { static let emoji = "❤️" }
extension PhotoViewModel: Service { static let emoji = "🖼️" }
extension CommunityViewModel: Service { static let emoji = "👨‍👩‍👦" }
extension MatchesViewModel: Service { static let emoji = "✉️" }
//extension ChatViewModel<Match>: Service { static let emoji = "💬" }
//extension ChatViewModel<CommunityTopic>: Service { static let emoji = "💬" }

