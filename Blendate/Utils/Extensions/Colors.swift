//
//  Constants.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import UIKit

extension Color {
    static let Blue = Color("Blue")
    static let DarkBlue = Color("DarkBlue")
//    static let BlueAlpha = Color(UIColor(red: 0.345, green: 0.396, blue: 0.965, alpha: 0.6))

//    static let LightPink = Color("LightPink")
    static let DarkPink = Color("DarkPink")
    
    static let LightGray = Color(UIColor.systemGray6)
    static let LightGray2 = Color(red: 0.9, green: 0.9, blue: 0.9)
    static let accent = Color("AccentColor")
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