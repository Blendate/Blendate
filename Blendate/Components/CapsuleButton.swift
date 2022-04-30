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
        if let fontsize = fontsize {
            content
                .padding(.horizontal)
                .fontType(.semibold, fontsize)
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
