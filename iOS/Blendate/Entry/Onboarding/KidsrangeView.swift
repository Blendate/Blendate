//
//  KidsrangeView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct KidsRangeView: View {
    @Binding var childrenRange: IntRange?
    
    @State var min: Int? = 0
    @State var max: Int? = 22
    
//    init(childrenRange: Binding<IntRange?>){
//        self._childrenRange = childrenRange
//        if let range = childrenRange.wrappedValue {
//            self.min = range.min
//            self.max = range.max
//
//        }
//    }
    

    var body: some View {
        VStack {
            Text("From")
                .font(.title2, .DarkBlue)
            AgeRangeView(value: $min, type: .range)
//                .onChange(of: childrenRange?.min) { newValue in
//                    if childrenRange.max < childrenRange.min {
//                        childrenRange.max = childrenRange.min
//                    }
//                }
            Text("To")
                .font(.title2, .DarkBlue)
            AgeRangeView(value: $max, type: .range)
        }
        .onAppear {
            if let childrenRange {
                self.min = childrenRange.min
                self.max = childrenRange.max
            }
        }
        .onChange(of: min) { newValue in
            let minValue = newValue ?? 0
            if childrenRange != nil {
                self.childrenRange?.min = minValue
            } else {
                self.childrenRange = IntRange(minValue, max ?? 22)
            }
        }
        .onChange(of: max) { newValue in
            let maxValue = newValue ?? 0
            if childrenRange != nil {
                self.childrenRange?.max = maxValue
            } else {
                self.childrenRange = IntRange(min ?? 0, maxValue)
            }
        }
    }
}



//#if DEBUG
//struct KidsRangeView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviewSignup(.childrenRange)
//    }
//}
//#endif
