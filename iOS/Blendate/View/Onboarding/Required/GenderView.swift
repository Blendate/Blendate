//
//  GenderView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct GenderView: View {
    @Binding var gender: String
    let detail: Detail
    var isFilter = false

    var body: some View {
        VStack{
            SignupTitle(detail, isFilter)
            HStack{
                Spacer()
                ItemButton($gender, Gender.male).padding(.trailing)
                ItemButton($gender, Gender.female).padding(.trailing)
                Spacer()
            }
            ItemButton($gender, Gender.nonBinary).padding(.trailing)
            Spacer()
        }
    }
}



struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.gender)
    }
}

struct SignupTitle: View {
    let detail: Detail
    let isFilter: Bool

    init(_ detail: Detail, _ isFilter: Bool = false){
        self.detail = detail
        self.isFilter = isFilter
    }

    var body: some View {
        Text(isFilter ? detail.filterTitle : detail.title)
            .fontType(.semibold, 32, .DarkBlue)
            .multilineTextAlignment(.center)
            .padding(.vertical)
            .padding(.horizontal)
    }
}
