//
//  KidsrangeView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct KidsRangeView: View {
    @Binding var childrenRange: IntRange

    var body: some View {
        VStack {
            Text("From")
                .fontType(.regular, 20, .DarkBlue)
            AgeRangeView(value: $childrenRange.min,type: .range, pickerCount: 22)
                .onChange(of: childrenRange.min) { newValue in
                    if childrenRange.max < childrenRange.min {
                        childrenRange.max = childrenRange.min
                    }
                }
            Text("To")
                .fontType(.regular, 20, .DarkBlue)
            AgeRangeView(value: $childrenRange.max, type: .range, pickerCount: 22)
        }
    }
}

#if DEBUG
struct KidsRangeView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.childrenRange)
    }
}
#endif
