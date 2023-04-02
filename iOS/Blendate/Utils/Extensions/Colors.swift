//
//  Constants.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import UIKit

extension Color {
    static let accent = Color("AccentColor")
    static let Blue = Color("Blue")
    static let DarkBlue = Color("DarkBlue")
    static let Purple = Color("Purple")
    
    static let LightGray5 = Color(UIColor.systemGray5)
    static let LightGray6 = Color(UIColor.systemGray6)
}
extension LinearGradient {
    static let horizontal = LinearGradient(gradient: Gradient(colors: [.Blue, .Purple]), startPoint: .leading, endPoint: .trailing)
    static let vertical = LinearGradient(gradient: Gradient(colors: [.Blue, .Purple]), startPoint: .bottom, endPoint: .top)

    static let corner = LinearGradient(gradient: Gradient(colors: [.Blue, .Purple]), startPoint: .bottomLeading, endPoint: .topTrailing)

}

public func ColorNavbar(){
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.DarkBlue)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.DarkBlue)]
}

extension Color {
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        

        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        
        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}
