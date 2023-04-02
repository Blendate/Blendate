//
//  DetailBackground.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/4/23.
//

import SwiftUI

extension View {
    func background(svg: String? = nil, bottom: Bool = true)->some View{
        modifier(DetailBackground(svg_name: svg, text: nil, bottom: bottom))
    }
    func background(text: String? = nil, bottom: Bool = true)->some View{
        modifier(DetailBackground(svg_name: nil, text: text, bottom: bottom))
    }
}
#warning("Switch to SVGs")
struct DetailBackground: ViewModifier {
    let svg_name: String?
    let text: String?
    let bottom: Bool

    var ellipse: String { bottom ? "Ellipse_Bottom" : "Ellipse_Top" }
    
    var alignment: Alignment { svg_name != nil ? .center : .top }
    
    func body(content: Content) -> some View {
        ZStack {
            VStack(spacing: 0) {
                if bottom {
                    Spacer()
                }
                ZStack(alignment: alignment) {
                    Image(ellipse)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height * 0.5,
                               alignment: .center)
                        .edgesIgnoringSafeArea(.vertical)
                    overlayView
                }
                if !bottom {
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            content
        }
    }
    
    @ViewBuilder
    var overlayView: some View {
        if let svg_name {
            Image(svg_name)
                .resizable()
                .scaledToFill()
                .frame(width: 270, height: 226 , alignment: .center)
        } else if let text {
            Text(text)
                .font(.title2, .white)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding(.top)
        } else {
            EmptyView()
        }
    }
    

}

struct DetailBackground_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            VStack {
                Spacer()
            }
            .background(svg: "Family")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Next"){}
                }
            }
        }
        VStack {
            Spacer()
        }
        .background(text: String(String.LoremIpsum.prefix(100)), bottom: false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Next"){}
            }
        }
    }
}
