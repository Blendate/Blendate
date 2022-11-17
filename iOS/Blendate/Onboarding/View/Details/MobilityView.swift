//
//  MobilityView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct MobilityView: View {
    @Binding var mobility: String
    
    var body: some View {
        VStack{
            SignupTitle(.mobility)
            ItemButton($mobility, Mobility.notWilling).padding(.bottom)
            ItemButton($mobility, Mobility.willing).padding(.bottom)
            ItemButton($mobility, Mobility.dontCare)
            Spacer()
        }
    }
}



struct MobilityView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.mobility)
    }
}