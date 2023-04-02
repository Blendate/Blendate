//
//  View+Extensions.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI


func getRect() -> CGRect{
    //// getRekt
    return UIScreen.main.bounds
}


extension View {
    func font( _ weight: SwiftUI.Font.Weight, _ color: Color) -> some View {
        self.fontWeight(weight).foregroundColor(color)
    }
    func font( _ font: SwiftUI.Font, _ color: Color) -> some View {
        self.font(font).foregroundColor(color)
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
