//
//  Modifiers.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
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

extension View {
    func capsuleButton(color: Color = Color.Blue, fontsize: CGFloat? = nil) -> some View {
        modifier(CapsuleButton(color: color, fontsize: fontsize))

    }
}


