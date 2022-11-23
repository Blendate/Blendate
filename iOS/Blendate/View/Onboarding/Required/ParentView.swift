//
//  ParenView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct ParentView: View {
    @Binding var isParent: Bool
    var isFilter = false

    var body: some View {
        VStack {
            SignupTitle(.isParent, isFilter)
            HStack {
                Item(title: "Yes", active: isParent) {
                    isParent = true
                }.padding(.horizontal)
                Item(title: "No", active: !isParent) {
                    isParent = false
                }.padding(.horizontal)
            }.padding(.bottom, 100)
            Spacer()
        }
    }
}



#if DEBUG
struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.isParent)
    }
}
#endif


