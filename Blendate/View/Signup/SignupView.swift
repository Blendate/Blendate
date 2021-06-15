//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/1/21.
//

import SwiftUI

struct SignupView: View {
    @Binding var user: User
    
    var body: some View {
        NavigationView {
            NameView(true, $user)
        }
        .environmentObject(ImagePickerModel())
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





