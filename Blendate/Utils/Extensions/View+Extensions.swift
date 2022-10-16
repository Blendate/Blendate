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
    func fontType(_ type: Font.Weight = .regular, _ size: CGFloat, _ color: Color? = nil) -> some View {
        return self.font(.system(size: size, weight: type)).foregroundColor(color)
    }
    
    func fontType(_ type: Font.Weight = .regular, _ font: SwiftUI.Font = .body, _ color: Color? = nil) -> some View {
        return self.font(font).fontWeight(type).foregroundColor(color)
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
