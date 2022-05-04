//
//  PoliticsView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct PoliticsView: View {
    @Binding var politics: String
    
    var body: some View {
        VStack(spacing: 20){
            SignupTitle(.politics)
            HStack{
                ItemButton($politics, Politics.liberal)
                ItemButton($politics, Politics.conservative)
            }
            HStack{
                ItemButton($politics, Politics.centrist)
                ItemButton($politics, Politics.other)

            }
            Spacer()
        }
    }
}


struct PoliticsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.politics)
    }
}
