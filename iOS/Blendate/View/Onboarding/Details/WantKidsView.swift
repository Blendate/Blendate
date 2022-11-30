//
//  WantKidsView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct WantKidsView: View {
    @Binding var wantKids: String
    var isFilter: Bool = false

    var body: some View {
        VStack{
            SignupTitle(.familyPlans, isFilter)
            ItemButton($wantKids, FamilyPlans.wantMore).padding(.trailing)
            ItemButton($wantKids, FamilyPlans.dontWant)
            OpenToAllButton($wantKids, isFilter)
            Spacer()
        }
    }
}


#if DEBUG
struct WantKids_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.familyPlans)
    }
}
#endif

