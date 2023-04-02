//
//  Swipe.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/17/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct Swipe: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    @ServerTimestamp var timestamp: Date?
    var action: String
    init(_ action: Action){
        self.action = action.rawValue
    }
}

extension Swipe {
    enum Action: String, CaseIterable, Codable, Identifiable {
        var id: String {rawValue}
        case pass = "pass", like = "like", superLike = "super_like", message = "message"
        
        var color: Color {
            switch self {
            case .pass: return .red
            case .like: return .Blue
            case .superLike, .message: return .Purple
            }
        }
        
        var imageName: String {
            switch self {
            case .pass: return "noMatch"
            case .like: return "icon"
            case .superLike: return "star.fill"
            case .message: return "envelope"
            }
        }
        
        var systemName: Bool {
            switch self {
            case .pass, .like: return false
            default: return true
            }
        }
    }
}

extension Swipe {
    struct Error: ErrorAlert {
        var title: String
        var message: String
    }
    struct SuperLike: ErrorAlert {
        var title = "Super Likes"
        var message = "You are out of Super Likes, purchase more to Super Likes"
    }
}

