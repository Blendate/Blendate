//
//  RelationshipView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct RelationshipView: View {
    @Binding var relationship: String

    var body: some View {
        VStack(spacing: 20){
            HStack{
                ItemButton($relationship, Status.single).padding(.trailing)
                ItemButton($relationship, Status.separated)
            }
            HStack{
                ItemButton($relationship, Status.divorced).padding(.trailing)
                ItemButton($relationship, Status.widowed)
            }
            HStack{
                ItemButton($relationship, Status.other).padding(.trailing)
            }
        }
    }
}



struct RelationshipView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.relationship)

    }
}
