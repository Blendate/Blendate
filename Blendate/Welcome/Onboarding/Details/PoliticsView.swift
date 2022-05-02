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
            HStack{
                ItemButton($politics, Politics.liberal).padding(.trailing)
                ItemButton($politics, Politics.conservative)
            }
            
            HStack{
                ItemButton($politics, Politics.centrist).padding(.trailing)
                ItemButton($politics, Politics.other)

            }
        }
    }
}


struct PoliticsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.politics)
    }
}
