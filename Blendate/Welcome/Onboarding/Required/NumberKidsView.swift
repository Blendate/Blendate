//
//  NumbersView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


enum PickType {
    case age
    case range
}

struct NumberKidsView: View {
    @Binding var children: Int
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack(){
            AgeRangeView(type: .age, pickerCount: 7, offset: $offset)
        }
        .padding(.bottom, 50)
        .onChange(of: offset) { newValue in
            children = 1 + Int(newValue / AgeTick.spacing)
        }
    }
}


#if DEBUG
struct NumberKidsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.numberKids)
    }
}
#endif
