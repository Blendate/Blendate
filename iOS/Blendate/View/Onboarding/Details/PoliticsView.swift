//
//  PoliticsView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct PoliticsView: View {
    @Binding var politics: String
    var isFilter: Bool = false

    var body: some View {
        VStack(spacing: 20){
            SignupTitle(.politics, isFilter)
            HStack{
                ItemButton($politics, Politics.liberal)
                ItemButton($politics, Politics.conservative)
            }
            HStack{
                ItemButton($politics, Politics.centrist)
                ItemButton($politics, Politics.other)
            }
            OpenToAllButton($politics, isFilter)
            Spacer()
        }
    }
}


struct PoliticsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.politics)
    }
}
