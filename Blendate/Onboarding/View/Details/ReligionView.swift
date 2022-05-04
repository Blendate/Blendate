//
//  ReligionView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct ReligionView: View {
    @Binding var religion: String
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            SignupTitle(.religion)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Religion.allCases, id: \.self) { item in
                        ItemButton($religion, item)
                    }
                }
            }
        }
    }
}



struct ReligionView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.religion)
    }
}
