//
//  CapsuleButton.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

extension View {
    
    func shapeButton(shape: ButtonBorderShape, color: Color = .Blue, font: Font = .title2) -> some View {
        modifier(ShapeButton(shape: shape, color: color, font: font, image: EmptyView()))
    }
    
    func shapeButton<I:View>(shape: ButtonBorderShape, color: Color = .Blue, font: Font = .title2, image: I) -> some View {
        modifier(ShapeButton(shape: shape, color: color, font: font, image: image))
    }
}

struct ShapeButton<I:View>: ViewModifier {
    let shape: ButtonBorderShape
    let color: Color
    let font: Font
    let image: I
    
    var foreground: Color { color == .white ? .DarkBlue : .white }
    
    func body(content: Content) -> some View {
            
        content
            .font(font.weight(.semibold))
            .tint(color)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(shape)
            .controlSize(.large)
            .foregroundColor(foreground)
    }
}

struct CapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Rounded Button"){}
            .shapeButton(shape: .roundedRectangle)
            .previewLayout(.sizeThatFits)
        
        Button("Capsule Button"){}
            .shapeButton(shape: .capsule)
            .previewLayout(.sizeThatFits)
    }
}
