//
//  WelcomeView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI

struct WelcomeView: View {
    @State var showEmail = false
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
    
    func emailTapped() async {
        if showEmail {
            do {
                try await UserService().sendEmail(to: email)
            } catch {
                self.error = error as? AlertError
            }
        } else {
            withAnimation(.spring()) {
                showEmail = true
            }
        }
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
            emailInput
            if showEmail {
                or
            }
            signinButtons
        }
        .background(Color.Blue)
        .cornerRadius(16)
        .padding(.top)
        .padding(.horizontal, 30)
        .shadow(radius: 10)
    }
    
    var emailInput: some View {
        VStack(spacing: 24) {
            if showEmail {
                emailField
            }
            emailButton
        }
        .padding(.top, 40)
        .padding(.horizontal, 56)
    }
    
    var or: some View {
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
    }
    
    
    var terms: some View {
        Text("By signing up, you agree to our [Terms](https://blendate.app) See what data we collect in our [Privacy Policy](https://blendate.app).")
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .font(.footnote)
            .foregroundColor(Color.gray)
    }
    
    
    
    var emailField: some View {
        TextField("tyler@blendate.app", text: $email)
            .textFieldStyle(.roundedBorder)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
    
    var emailButton: some View {
        AsyncButton(action: emailTapped) {
            HStack {
                Image(systemName: "envelope.fill")
                    .foregroundColor(.Blue)
                Text("Sign in with Email")
                    .fontType(.semibold, 12, .Blue)
                Spacer()
            }
            .padding(.vertical, 10)
            .padding(.leading, 10)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
    

    
    var signinButtons: some View {
        SocialSigninButtons()
//        Rectangle().fill(Color.gray)
            .frame(height:240)
            .noPreview(220, 240, "Social Button")
    }

}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(showEmail: true)
    }
}



