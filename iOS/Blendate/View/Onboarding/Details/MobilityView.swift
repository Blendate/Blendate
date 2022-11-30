//
//  MobilityView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct MobilityView: View {
    @Binding var mobility: String
    var isFilter: Bool = false

    var body: some View {
        VStack{
            SignupTitle(.mobility, isFilter)
            ItemButton($mobility, Mobility.notWilling).padding(.bottom)
            ItemButton($mobility, Mobility.willing).padding(.bottom)
            ItemButton($mobility, Mobility.dontCare)
            OpenToAllButton($mobility, isFilter)
            Spacer()
        }
    }
}



struct MobilityView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.mobility)
    }
}
