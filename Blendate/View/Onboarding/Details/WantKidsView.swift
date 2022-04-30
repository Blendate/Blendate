//
//  WantKidsView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct WantKidsView: View {
    @Binding var wantKids: String
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                ItemButton($wantKids, FamilyPlans.wantMore).padding(.trailing)
                ItemButton($wantKids, FamilyPlans.dontWant)
                Spacer()
            }
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

