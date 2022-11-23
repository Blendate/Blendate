//
//  VicesView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct VicesView: View {
    @Binding var vices: [String]
    var isFilter: Bool = false
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            SignupTitle(.vices, isFilter)
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Vices.allCases, id: \.self) { item in
                        ItemArray($vices, item)
                    }
                }
            }
        }
    }
}



struct VicesView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.vices)
    }
}
