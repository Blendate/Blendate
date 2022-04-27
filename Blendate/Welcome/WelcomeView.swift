//
//  WelcomeView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showEmail = false
    
    var body: some View {
        VStack {
            card
            Spacer()
            terms
        }
        .sheet(isPresented: $showEmail) {
            EmailSigninView()
        }
    }
}

extension WelcomeView {
    
    var card: some View {
        VStack {
            logoheader
                .padding(.top, 30)
            Spacer()
            signinButtons
        }
        .background(Color.Blue)
        .cornerRadius(16)
        .padding(.vertical, 40)
        .padding(.horizontal, 30)
        .shadow(radius: 10)
    }
    
    var logoheader: some View {
        VStack {
            Image.icon(100, .white)
            Text("Blendate")
                .fontType(.semibold, 52, .white)
            Text("Find your blended family")
                .fontType(.semibold, 16, .white)
        }
    }

    
    var terms: some View {
        Text("By signing up, you agree to our [Terms](https://blendate.app) See what data we collect in our [Privacy Policy](https://blendate.app).")
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.bottom, 6)
            .foregroundColor(Color.gray)
    }
    
    var signinButtons: some View {
        VStack {
            emailButton
            SocialSigninButtons()
                .frame(height:240)
                .noPreview(140, 240, "Social Button")
        }
    }
    
    var emailButton: some View {
        Button {
            showEmail = true
        } label: {
            HStack {
                Image(systemName: "envelope")
                Text("Sign in with Email")
                    .font(Font.footnote)
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
        }
        .frame(width: 220)
        .background(Color.white)
        .cornerRadius(20)

    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}



