//
//  EmptyLineupView.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI

struct EmptyLineupView: View {
    @State var showPref = false
    @Binding var sessionUser: User
    
    var body: some View {
        VStack {
            Spacer()
            Image("Family")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 250 , alignment: .top)
            Spacer()
            Text("There are no more profiles with your current filters, change some filters to see more profiles")
                .fontType(.regular, 24, .DarkBlue)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button(action: {showPref.toggle()}) {
                Text("Filters")
                    .fontType(.semibold, 18, .white)
                    .padding()
                    .background(Color.Blue)
                    .cornerRadius(16)
            }
            .padding(.top)
            Spacer()
        }
//        .elipseBackground(true)
        .sheet(isPresented: $showPref, onDismiss: {
            try? UserService().updateUser(with: sessionUser)
        }) {
            FiltersView(user: $sessionUser)
        }
    }
}

struct EmptyLineupView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyLineupView(sessionUser: .constant(dev.michael))
    }
}
