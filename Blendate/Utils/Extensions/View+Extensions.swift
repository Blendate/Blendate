//
//  View+Extensions.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI


func getRect() -> CGRect{
    return UIScreen.main.bounds
}


extension View {
    func fontType(_ type: Font.Weight = .regular, _ size: CGFloat = 14, _ color: Color? = nil) -> some View {
        return self.font(.system(size: size, weight: type)).foregroundColor(color)
    }
}
