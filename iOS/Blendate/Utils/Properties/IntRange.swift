//
//  IntRange.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI
import Sliders
protocol IntRange: Property {
    var min: Int {get set}
    var max: Int {get set}
    init(min: Int, max: Int)
    static var range: ClosedRange<Int> { get }
    static var defaultValue: Self { get }
}

extension IntRange {
    func maxLabel(max: Int) -> String {
        if self.max >= max {
            return "\(max - 1)+"
        } else {
            return String(self.max)
        }
    }
    func minLabel(min: Int) -> String {
        if self.min <= 0 {
            return "<1"
        } else {
            return String(self.min)
        }
    }

    var valueLabel: String {
        "\(minLabel(min: Self.range.lowerBound)) - \(maxLabel(max: Self.range.upperBound))"
    }
    
    var isValid: Bool {
        min >= Self.range.lowerBound && max <= Self.range.upperBound
    }
    
    static var defaultValue: Self { Self(min: range.lowerBound, max: range.upperBound) }

}


struct AgeRange: IntRange {
    var min, max: Int
    static let range: ClosedRange<Int> = .init(uncheckedBounds: (18,76))
    struct PropertyView: PropertyViewProtocol {
        var value: Binding<AgeRange>
        var isFilter: Bool
        var body: some View {
            ZStack{}
        }
    }
    static let title = "Age"
    static let systemImage = "birthday.cake"
}

struct RangeCell<R:IntRange>: View {
    @Binding var ageRange: R
    @State var range: ClosedRange<Int>

    var label: String { R.label}
    var systemImage: String { R.systemImage }
    var rangeIn: R { R.defaultValue }

    var disabled: Bool = false

    var color: Color {
        disabled ? .gray : .purple
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            PropertyCell(title: label, label: ageRange.valueLabel, systemImage: systemImage)
            RangeSlider(range: $range, in: rangeIn.min...rangeIn.max, step: 1)
                .rangeSliderStyle(
                    HorizontalRangeSliderStyle( track:
                        HorizontalRangeTrack(
                            view: Capsule().foregroundColor(color)
                        )
                        .background(Capsule().foregroundColor(color.opacity(0.25)))
                        .frame(height: 4)
                      )
                )
        }
        .onChange(of: range) { newValue in
            if let min = newValue.min() {
                ageRange.min = min
            }
            if let max = newValue.max() {
                ageRange.max = max
            }
        }
    }
}
