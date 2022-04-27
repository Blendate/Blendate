//
//  Constants.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

extension Color {
    static let Blue = Color("Blue")
    static let DarkBlue = Color("DarkBlue")
//    static let BlueAlpha = Color(UIColor(red: 0.345, green: 0.396, blue: 0.965, alpha: 0.6))

//    static let LightPink = Color("LightPink")
    static let DarkPink = Color("DarkPink")
    
    static let LightGray = Color(UIColor.systemGray6)
    static let LightGray2 = Color(red: 0.9, green: 0.9, blue: 0.9)
}

public func ColorNavbar(){
    UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.DarkBlue)]
    UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.DarkBlue)]
}
