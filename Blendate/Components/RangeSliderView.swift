//
//  RangeSliderView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI

struct RangeSliderView: View {
    
    @State var width: CGFloat
    @State var width2: CGFloat
    var totalWidth = UIScreen.main.bounds.width - 120
    let title: String
    
    private let cirlceWidth: CGFloat = 26

    @Binding var min: Int
    @Binding var max: Int
    
    
    init(title: String, min: Binding<Int>, max: Binding<Int>){
        self.title = title
        self._min = min
        self._max = max
        
        self.width = CGFloat( CGFloat(min.wrappedValue - 18) / 100)  * totalWidth
        self.width2 = CGFloat( CGFloat(max.wrappedValue) / 100)  * totalWidth

    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.20))
                    .frame(height: 4)
                Rectangle()
                    .fill(Color.Blue)
                    .frame(width: self.width2 - self.width, height: 4)
                    .offset(x: self.width + cirlceWidth)
                HStack(spacing: 0) {
                    Circle()
                        .fill(Color.white)
                        .frame(width: cirlceWidth, height: cirlceWidth)
                        .offset(x: self.width)
                        .gesture(DragGesture().onChanged({ value in
                            if value.location.x >= 0 && value.location.x <= self.width2 {
                                self.width = value.location.x
                            }
                        }))
                        .shadow(color: .gray, radius: 3, x: 0, y:3)

                    Circle()
                        .fill(Color.white)
                        .frame(width: cirlceWidth, height: cirlceWidth)
                        .offset(x: self.width2)
                        .gesture(DragGesture().onChanged({ value in
                            if value.location.x <= totalWidth && value.location.x >= self.width {
                                self.width2 = value.location.x
                            }
                        }))
                        .shadow(color: .gray, radius: 3, x: 0, y:3)

                }
            }
        }
//        .padding()
        .onChange(of: width) { newValue in
            self.min = proxyValue(val: newValue) + 18
        }
        .onChange(of: width2) { newValue in
            self.max = proxyValue(val: newValue)
        }
    }
    
    
    func proxyValue(val: CGFloat)->Int {
        let valueDiff = val / totalWidth
        return Int(valueDiff * 100)
    }
}

struct RangeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RangeSliderView(title: "Title", min: .constant(16), max: .constant(66))
            Slider(value: .constant(50), in: 10.0...100.0)
        }
    }
}
