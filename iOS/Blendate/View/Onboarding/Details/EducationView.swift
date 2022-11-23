//
//  EducationView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct EducationView: View {
    @Binding var schoolTitle: String
    var isFilter: Bool = false

    var body: some View {
        VStack{
            SignupTitle(.education, isFilter)
            Text("What University, College, or High School did you attend?")
                .fontType(.regular, 16, .DarkBlue)
                .padding(.top,5)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            TextField("", text: $schoolTitle)
                .fontType(.semibold, 22)
                .padding(.horizontal, 40)
                .foregroundColor(.DarkBlue)
                .textFieldStyle(.roundedBorder)
            Spacer()
        }
    }
}

struct EducationView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.education)
    }
}
