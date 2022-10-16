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
                    .fontWeight(.semibold)
                    .foregroundColor(color)
            }
        }
    }
    
    init(placment: ToolbarItemPlacement, imageNamed: String, color: Color = .Blue, action: @escaping () -> Void) where Content == Button<Image> {
        self.init(placement: placment) {
            Button(action: action) {
                Image(imageNamed)
//                    .foregroundColor(color) as! Image
            }
        }
    }
    
    init(placment: ToolbarItemPlacement, systemImage: String, color: Color = .Blue, action: @escaping () -> Void) where Content == Button<Image> {
        self.init(placement: placment) {
            Button(action: action) {
                Image(systemName: systemImage)
//                    .foregroundColor(color) as! Image
            }
        }
    }
}
