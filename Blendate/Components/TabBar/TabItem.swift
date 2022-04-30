//
//  TabItem.swift
//  Blendate
//
//  Created by Michael on 4/1/22.
//

import Foundation

struct TabItemData {
    let image: String
    let selectedImage: String
    let title: String
}

enum TabType: Int, CaseIterable, Identifiable {
    var id: Int {self.rawValue}
    case lineup
    case messages
    case today
    case profile
        
    var tabItem: TabItemData {
        switch self {
        case .lineup:
            return TabItemData(image: "icon-2", selectedImage: "icon-2", title: "Lineup")
        case .messages:
            return TabItemData(image: "chat", selectedImage: "chat", title: "Blends")
        case .today:
            return TabItemData(image: "heart", selectedImage: "heart", title: "Today")
        case .profile:
            return TabItemData(image: "profile", selectedImage: "profile", title: "profile")
        }
    }
}
