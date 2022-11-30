//
//  EmptyLineupView.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI

struct EmptyLineupView: View {
    @EnvironmentObject var session: SessionViewModel
    @State private var showFilters = false

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
            Button(action: {showFilters.toggle()}) {
                Text("Filters")
                    .fontType(.semibold, 18, .white)
                    .padding()
                    .background(Color.Blue)
                    .cornerRadius(16)
            }
            .padding(.top)
            Spacer()
        }
        .sheet(isPresented: $showFilters) {
            try? session.saveUser()
        } content: {
            NavigationStack {
                FiltersView()
            }
        }
//        .elipseBackground(true)

    }
}

struct EmptyLineupView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyLineupView()
    }
}
