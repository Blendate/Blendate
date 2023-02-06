//
//  ParenView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct ParentView: View {
    @Binding var isParent: Bool
    
    var parent: Binding<String> {
        .init { isParent ? "Yes" : "No" }
        set: { isParent = $0 == "Yes" }
    }

    var body: some View {
        OptionGridView<Yes, String>(parent)

    }
}



#if DEBUG
struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.isParent)
    }
}
#endif


