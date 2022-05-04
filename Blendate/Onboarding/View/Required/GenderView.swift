//
//  GenderView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct GenderView: View {
    @Binding var gender: String
    let detail: SignupDetail

    var body: some View {
        VStack{
            SignupTitle(detail)
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
    let detail: SignupDetail

    init(_ detail: SignupDetail){
        self.detail = detail
    }

    var body: some View {
        if detail.hasTitle {
            Text(detail.title)
                .fontType(.semibold, 32, .DarkBlue)
                .multilineTextAlignment(.center)
                .padding(.vertical)
                .padding(.horizontal)
        } else {
            Text(" ")
                .fontType(.semibold, 32)
                .padding(.vertical)
        }
    }
}
