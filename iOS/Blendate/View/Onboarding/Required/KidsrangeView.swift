//
//  KidsrangeView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct KidsRangeView: View {
    @Binding var childrenRange: IntRange
    var isFilter = false

//    @State var minOffset: CGFloat = 0
//    @State var maxOffset: CGFloat = 0
    var minOffset: Binding<CGFloat> {
        .init {
            CGFloat(childrenRange.min - 1) * AgeTick.spacing
        } set: { newValue in
            childrenRange.min = 1 + Int(newValue / AgeTick.spacing)
        }

    }
    
    var maxOffset: Binding<CGFloat> {
        .init {
            CGFloat(childrenRange.max - 1) * AgeTick.spacing
        } set: { newValue in
            childrenRange.max = 1 + Int(newValue / AgeTick.spacing)
        }

    }
    
    var body: some View {
        VStack(spacing: 0) {
            SignupTitle(.childrenRange, isFilter)
            Text("From")
                .fontType(.regular, 20, .DarkBlue)
            AgeRangeView(type: .range, pickerCount: 22, offset: minOffset)
            Text("To")
                .fontType(.regular, 20, .DarkBlue)
            AgeRangeView(type: .range, pickerCount: 22, offset: maxOffset)
            Spacer()
        }
//        .padding(.bottom)
//        .onChange(of: minOffset) { newValue in
//            let value = 1 + Int(newValue / AgeTick.spacing)
//            if value > childrenRange.max {
//                childrenRange.max = value
//            } else {
//                childrenRange.min = value
//
//            }
//        }
//        .onChange(of: maxOffset) { newValue in
//            childrenRange.max = 1 + Int(newValue / AgeTick.spacing)
//        }
    }
    

}

#if DEBUG
struct KidsRangeView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.childrenRange)
    }
}
#endif
