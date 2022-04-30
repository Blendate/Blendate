//
//  RangeSliderView.swift
//  Blendate
//
//  Created by Michael on 3/30/22.
//

import SwiftUI


struct RangeSliderView: View {
    

    let totalWidth: CGFloat
    
    private let cirlceWidth: CGFloat = 26

    @Binding var range: IntRange
//    let slider: IntRange
    let ratio: CGFloat
    let slider: IntRange

    
    init(range: Binding<IntRange>, totalWidth: CGFloat, slider: IntRange){
        self._range = range
        self.totalWidth = totalWidth
        self.ratio = totalWidth / CGFloat(slider.max)
        self.slider = slider
    }
    
    func locationToValue(_ location: CGFloat) -> Int {
        return Int(location / ratio)
    }
    
    func valueToLocation(_ value: Int)->CGFloat {
        return CGFloat(ratio * CGFloat(value))
    }

    var valueMax: Binding<CGFloat> {
        .init {
            valueToLocation(range.max - slider.min)
        } set: { newValue in
            range.max = locationToValue(newValue) + slider.min
        }
    }
    
    var valueMin: Binding<CGFloat> {
        .init {
            valueToLocation(range.min - slider.min)
        } set: { newValue in
            range.min = locationToValue(newValue) + slider.min
        }
    }

    
    var body: some View {
        ZStack(alignment: .leading) {
            backgroundline
            filledline
            HStack(spacing: 0) {
                minCirlce
                maxCircle
            }
        }
    }

}

extension RangeSliderView {
    var backgroundline: some View {
        Rectangle()
            .fill(Color.black.opacity(0.20))
            .frame(height: 4)
    }
    
    var filledline: some View {
        Rectangle()
            .fill(Color.Blue)
            .frame(width: valueMax.wrappedValue - valueMin.wrappedValue, height: 4)
            .offset(x: valueMin.wrappedValue + cirlceWidth)
    }
    
    var minCirlce: some View {
        circle
            .offset(x: valueMin.wrappedValue)
            .gesture(DragGesture().onChanged { value in
                if value.location.x >= valueToLocation(slider.min) &&
                    value.location.x <= valueMax.wrappedValue {
                    self.range.min = Int(value.location.x / ratio)
//                    self.minWidth = value.location.x
                }
            })
    }
    
    var maxCircle: some View {
        circle
            .offset(x: valueMax.wrappedValue)
            .gesture(DragGesture().onChanged { value in
                if value.location.x <= valueToLocation(slider.max) &&
                    value.location.x >= CGFloat(slider.max)  {
                    self.range.max = Int(value.location.x / ratio)
//                    self.maxWidth = value.location.x
                }
            })
    }
    
    var circle: some View {
        Circle()
            .fill(Color.white)
            .frame(width: cirlceWidth, height: cirlceWidth)
            .shadow(color: .gray, radius: 3, x: 0, y:3)
    }
}

struct RangeSliderView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader {geo in
            List {
                VStack {
                    HStack {
                        Text("Label")
                        Spacer()
                        Text(dev.bindingMichael.filters.ageRange.label)
                    }
                    RangeSliderView(range: dev.$bindingMichael.filters.ageRange, totalWidth: geo.size.width, slider: IntRange(18, 75))
                }
            }
        }
    }
}
