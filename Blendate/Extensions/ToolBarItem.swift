//
//  ToolBarItem.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

extension ToolbarItem where ID == Void {
    init(placment: ToolbarItemPlacement, title: String, color: Color = .Blue, action: @escaping () -> Void) where Content == Button<Text> {
        self.init(placement: placment) {
            Button(action: action) {
                Text(title)
                    .foregroundColor(color)
            }
        }
    }
}
