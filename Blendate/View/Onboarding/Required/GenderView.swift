//
//  GenderView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct GenderView: View {
    @Binding var gender: String

    var body: some View {
        VStack(spacing: 30){
            HStack{
                ItemButton($gender, Gender.male).padding(.trailing)
                ItemButton($gender, Gender.female).padding(.trailing)
            }
            ItemButton($gender, Gender.nonBinary).padding(.trailing)
        }
    }
}



struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.gender)
        
    }
}
