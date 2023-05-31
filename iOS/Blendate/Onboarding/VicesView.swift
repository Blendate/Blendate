//
//  VicesView.swift
//  Blendate
//
//  Created by Michael on 5/31/23.
//

import SwiftUI

struct VicesView: View {
    @Binding var vices: [Vices]
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Vices.allCases, id: \.rawValue) { item in
                        Button {
                            vices.tapItem(item)
                        } label: {
                            ButtonView(title: item.rawValue, active: vices.contains(item) )
                        }
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct VicesView_Previews: PreviewProvider {
    static var previews: some View {
        VicesView(vices: .constant(alice.vices))
    }
}
