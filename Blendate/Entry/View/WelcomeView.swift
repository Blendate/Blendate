//
//  WelcomeView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct WelcomeView: View {
    @StateObject var model = WelcomeViewModel()
    @State var email: String = ""
    @State var error: AlertError?
    
    var body: some View {
        VStack(spacing: 0) {
            header
            Spacer()
            card
            Spacer()
            terms
        }
        .errorAlert(error: $error)
    }

    

}
extension WelcomeView {
    
    var header: some View {
        VStack(spacing: 0) {
            Image.icon(60, .Blue)
                .padding(.top, 10)
            Text("Blendate")
                .fontType(.semibold, 60, .Blue)
            Text("Find your blended family")
                .fontType(.semibold, 16, .Blue)
        }
    }
    
    var card: some View {
        VStack {
            emailField
            emailButton
            HStack {
                Rectangle().fill(Color.LightGray)
                    .frame(height: 1)
                Text("or")
                    .foregroundColor(.LightGray)
                Rectangle().fill(Color.LightGray)
                    .frame(height: 1)
            }
            .padding(.horizontal)
            .padding([.horizontal,.top])
            signinButtons
        }
        .background(Color.Blue)
        .cornerRadius(16)
        .padding(.top)
        .padding(.horizontal, 30)
        .shadow(radius: 10)
    }

    
    
    var emailField: some View {
        TextField("name@email.com", text: $email)
            .textFieldStyle(.roundedBorder)
            .padding()
            .padding(.top)
            .padding(.horizontal, 16)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
    
    var emailButton: some View {
        AsyncButton(action: emailTapped) {
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.Blue)
                Text("Sign in with email")
                    .fontType(.semibold, 14, .Blue)
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.leading, 10)
            .background(Color.white)
            .cornerRadius(20)
        }
        .padding(.horizontal, 32)
    }
    

    
    var signinButtons: some View {
//        SocialSigninButtons()
        VStack {
            GoogleSignInButton()
              .padding()
              .onTapGesture {
                  model.googleSignIn()
              }
        }
            .frame(height:240)
            .noPreview(220, 240, "Social Button")
    }
    
    
    
    var terms: some View {
        Text("By signing up, you agree to our [Terms](https://blendate.app) See what data we collect in our [Privacy Policy](https://blendate.app).")
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .font(.footnote)
            .foregroundColor(Color.gray)
    }
    
}

extension WelcomeView {
    
    func emailTapped() async {
        do {
            try await FirebaseManager.instance.sendEmail(to: email)
        } catch {
            self.error = error as? AlertError
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
