//
//  KidAgeRange.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/8/23.
//

import SwiftUI

struct KidAgeRange: IntRange {
    var min, max: Int
    
    static let range: ClosedRange<Int> = .init(uncheckedBounds: (0,18))
    static let systemImage = "birthday.cake"
    static let title = "Children Ages"

}

extension KidAgeRange {
    struct PropertyView: PropertyViewProtocol {
        @Binding var childrenRange: KidAgeRange
        
        init(value: Binding<KidAgeRange>, isFilter: Bool = false) {
            self._childrenRange = value
        }
        
        @State var min: Int = 0
        @State var max: Int = 22
        
        var body: some View {
            VStack {
                Text("From")
                    .font(.title2, .DarkBlue)
                AgeRangeView(value: $min, type: .range)
                Text("To")
                    .font(.title2, .DarkBlue)
                AgeRangeView(value: $max, type: .range)
            }
            .onAppear {
                self.min = childrenRange.min
                self.max = childrenRange.max
            }
            .onChange(of: min) { newValue in
                self.childrenRange.min = newValue

            }
            .onChange(of: max) { newValue in
                self.childrenRange.max = newValue
            }        }
    }
}
