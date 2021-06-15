//
//  Modifiers.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/16/21.
//

import SwiftUI

struct CircleViewModifier: ViewModifier {
    
    let color: Color
    
    init(_ color: Color){
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(color, lineWidth: 1))
    }
}

extension View {
    func circle(_ color: Color = Color.white) -> some View {
        self.modifier(CircleViewModifier(color))
    }
}

extension Image {
    func circle(_ color: Color = Color.white) -> some View {
        self.modifier(CircleViewModifier(color))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
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


extension View {
  func circleBackground(
    imageName: String,
    isTop: Bool = true) -> some View {
      modifier(CircleBackground(isTop: isTop, imageName: imageName))
  }
}

struct CircleBackground: ViewModifier {
    let isTop: Bool
    let imageName: String
    
    func body(content: Content) -> some View {
        content
            .background(
                ZStack{
                    Color("LightPink")
                        .ignoresSafeArea()
                    VStack{
                        if !isTop {
                            Spacer()
                        }
                        ZStack(alignment:.center){
                            Image(isTop ? "Ellipse_Top":"Ellipse_Bottom")
                                .resizable()
                                .scaledToFill()
                                .ignoresSafeArea()
                                .frame(height: UIScreen.main.bounds.height * 0.5, alignment: .center)
                            Image(imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 270, height: 226 , alignment: .center)
                        }
                        if isTop {
                            Spacer()
                        }
                        
                    }
                })
//            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarBackButtonHidden(true)
//            .navigationBarHidden(true)
    }
}
