//
//  CapsuleButton.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

extension View {
    func capsuleButton(color: Color = Color.Blue, fontsize: CGFloat? = nil) -> some View {
        modifier(CapsuleButton(color: color, fontsize: fontsize))
    }
}

struct CapsuleButton: ViewModifier {
    let color: Color
    let fontsize: CGFloat?
    func body(content: Content) -> some View {
        let foreground:Color = color == .Blue ? .white:.accentColor
        if let fontsize = fontsize {
            content
                .padding(.horizontal)
                .fontType(.semibold, fontsize, foreground)
                .tint(color)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
        } else {
            content
                .tint(color)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
                .foregroundColor(foreground)
        }
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Capsule Button"){}
            .capsuleButton()
            .previewLayout(.sizeThatFits)
    }
}
