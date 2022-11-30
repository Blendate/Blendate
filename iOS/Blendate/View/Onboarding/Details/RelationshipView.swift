//
//  RelationshipView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct RelationshipView: View {
    @Binding var relationship: String
    var isFilter: Bool = false

    var body: some View {
        VStack(spacing: 20){
            SignupTitle(.relationship, isFilter)
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
            OpenToAllButton($relationship, isFilter)
            Spacer()
        }
    }
}



struct RelationshipView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.relationship)
        RelationshipView(relationship: .constant(Status.single.rawValue), isFilter: true)
    }
}
