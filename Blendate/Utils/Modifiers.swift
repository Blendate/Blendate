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
    imageName: String?,
    isTop: Bool = true) -> some View {
      modifier(CircleBackground(isTop: isTop, imageName: imageName))
  }
}

struct CircleBackground: ViewModifier {
    let isTop: Bool
    let imageName: String?
    
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
                            VStack {
                                if let imageString = imageName {
                                    Image(imageString)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 270, height: 226 , alignment: .center)
                                        .offset(y: !isTop ? 60:-60)
                                } else {
                                    EmptyView()
                                }

                            }
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

func stringToDouble(_ string: String)->Double {
    let replaced = string.replacingOccurrences(of: "'", with: ".")
    return Double(replaced)!
}

func doubleToString(_ double: Double)->String {
    let string = String(double)
    let replaced = string.replacingOccurrences(of: ".", with: "'")
    return replaced
}
struct ScrollingHStackModifier: ViewModifier {
    
    @State private var scrollOffset: CGFloat
    @State private var dragOffset: CGFloat
    
    var items: Int
    var itemWidth: CGFloat
    var itemSpacing: CGFloat
    
    init(items: Int, itemWidth: CGFloat, itemSpacing: CGFloat) {
        self.items = items
        self.itemWidth = itemWidth
        self.itemSpacing = itemSpacing
        
        // Calculate Total Content Width
        let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
        let screenWidth = UIScreen.main.bounds.width
        
        // Set Initial Offset to first Item
        let initialOffset = (contentWidth/2.0) - (screenWidth/2.0) + ((screenWidth - itemWidth) / 2.0)
        
        self._scrollOffset = State(initialValue: initialOffset)
        self._dragOffset = State(initialValue: 0)
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: scrollOffset + dragOffset, y: 0)
            .gesture(DragGesture()
                .onChanged({ event in
                    dragOffset = event.translation.width
                })
                .onEnded({ event in
                    // Scroll to where user dragged
                    scrollOffset += event.translation.width
                    dragOffset = 0
                    
                    // Now calculate which item to snap to
                    let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
                    let screenWidth = UIScreen.main.bounds.width
                    
                    // Center position of current offset
                    let center = scrollOffset + (screenWidth / 2.0) + (contentWidth / 2.0)
                    
                    // Calculate which item we are closest to using the defined size
                    var index = (center - (screenWidth / 2.0)) / (itemWidth + itemSpacing)
                    
                    // Should we stay at current index or are we closer to the next item...
                    if index.remainder(dividingBy: 1) > 0.5 {
                        index += 1
                    } else {
                        index = CGFloat(Int(index))
                    }
                    
                    // Protect from scrolling out of bounds
                    index = min(index, CGFloat(items) - 1)
                    index = max(index, 0)
                    
                    // Set final offset (snapping to item)
                    let newOffset = index * itemWidth + (index - 1) * itemSpacing - (contentWidth / 2.0) + (screenWidth / 2.0) - ((screenWidth - itemWidth) / 2.0) + itemSpacing
                    
                    // Animate snapping
                    withAnimation {
                        scrollOffset = newOffset
                    }
                    
                })
            )
    }
}
