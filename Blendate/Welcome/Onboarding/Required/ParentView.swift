//
//  ParenView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct ParentView: View {
    @Binding var isParent: Bool
        
    var body: some View {
        VStack {
            HStack {
                Item(title: "Yes", active: isParent) {
                    isParent = true
                }.padding(.horizontal)
                Item(title: "No", active: !isParent) {
                    isParent = false
                }.padding(.horizontal)
            }.padding(.bottom, 100)
        }
    }
}

struct Item: View {
    let title: String
    let active: Bool
    var action: ()->Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontType(.regular, 18, active ? .white:.Blue)
                .padding(.horizontal)
                .padding()
                .background(active ? Color.Blue:Color.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.Blue, lineWidth: 2)
                )
        }
    }
}

#if DEBUG
struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.parent)
    }
}
#endif


