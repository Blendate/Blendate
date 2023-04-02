//
//  SettingCellView.swift
//  Blendate
//
//  Created by Michael on 4/10/22.
//

import SwiftUI

enum Provider: String, Codable, Identifiable, Hashable, CaseIterable {
    var id: String {self.rawValue}
    case apple = "Apple"
    case facebook = "Facebook"
    case phone = "Phone"
    
    var image: String {
        switch self {
        case .apple:
            return "apple.logo"
        case .facebook:
            return "phone.fill"
        case .phone:
            return "phone.fill"
        }
    }
}
