//
//  SeperatorView.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

struct SeperatorView: View {
    
    let size:Int
    let color: Color
    
    init(_ size: Int = 1, _ color: Color = Color.white){
        self.size = size
        self.color = color
    }
    
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: CGFloat(size))
            .frame(height: 30)
            .opacity(0.2)
    }
}

struct SeperatorView_Previews: PreviewProvider {
    static var previews: some View {
        SeperatorView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
