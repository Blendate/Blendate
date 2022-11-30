//
//  EthnicityView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct EthnicityView: View {
    @Binding var ethnicity: String
    var isFilter: Bool = false

    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    #warning("fix photo")
    var body: some View {
        VStack {
            SignupTitle(.ethnicity, isFilter)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Ethnicity.allCases, id: \.self) { item in
                        ItemButton($ethnicity, item)
                    }
                    OpenToAllButton($ethnicity, isFilter)

                }
            }
        }
    }
}



struct EthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.ethnicity)
    }
}
