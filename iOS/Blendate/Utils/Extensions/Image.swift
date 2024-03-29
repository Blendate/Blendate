//
//  Image.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

enum ImageType: String {case icon}
extension Image {
    
    static func Icon(size: CGFloat = 100, _ color: Color = .Blue) -> some View {
        Image("icon")
            .renderingMode(.template)
            .resizable()
            .frame(width: (size * 0.75) , height: size)
            .foregroundColor(color)
    }
}
