//
//  KidsrangeView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct KidsRangeView: View {
    @Binding var childrenRange: IntRange

    @State var minOffset: CGFloat = 0
    @State var maxOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Text("From")
                .fontType(.regular, 20, .DarkBlue)
            AgeRangeView(type: .range, pickerCount: 22, offset: $minOffset)
            Text("To")
                .fontType(.regular, 20, .DarkBlue)
            AgeRangeView(type: .range, pickerCount: 22, offset: $maxOffset)

        }
        .padding(.bottom)
        .onChange(of: minOffset) { newValue in
            childrenRange.min = 1 + Int(newValue / AgeTick.spacing)
        }
        .onChange(of: maxOffset) { newValue in
            childrenRange.max = 1 + Int(newValue / AgeTick.spacing)
        }
    }
    

}

#if DEBUG
struct KidsRangeView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.kidsRange)
    }
}
#endif
