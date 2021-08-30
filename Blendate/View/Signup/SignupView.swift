//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationView {
            NameView(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ImagePlaceHolder: View {
    
    var body: some View {
        Text("PlaceHolder")
            .foregroundColor(.white)
            .frame(height: 160)
            .background(Color.Pink)
    }
}





