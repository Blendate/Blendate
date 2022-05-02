//
//  WelcomeView.swift
//  Blendate
//
//  Created by Michael on 12/7/21.
//

import SwiftUI
import FirebaseEmailAuthUI
import FirebaseAuth

struct WelcomeView: View {
    @State var showEmail = false
    @State var email: String = ""
    @State var error: AlertError?
    
    var body: some View {
        VStack(spacing: 0) {
            Image.icon(60, .Blue)
            logoheader
            Spacer()
            card
            Spacer()
            terms
        }
        .errorAlert(error: $error)

    }
    
    var card: some View {
        VStack(spacing: 0) {
            VStack {
                emailField
                    .padding(.top)
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
    }
    
    
    var emailField: some View {
        VStack {
            TextField("tyler@blendate.app", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding()
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            AsyncButton("Sign in", action: sendEmail)
            .fontType(.semibold, 22)
            .tint(.white)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle(radius: 5))
            .controlSize(.regular)
            .foregroundColor(.Blue)
//            .capsuleButton(color: .white, fontsize: 22)
        }
    }
    
    var signinButtons: some View {
        VStack {
            SocialSigninButtons()
                .frame(height:240)
                .noPreview(220, 240, "Social Button")
        }
    }

    var logoheader: some View {
        VStack(spacing: 0) {
            Text("Blendate")
                .fontType(.semibold, 60, .Blue)
            Text("Find your blended family")
                .fontType(.semibold, 16, .Blue)
        }
    }
    
    var terms: some View {
        Text("By signing up, you agree to our [Terms](https://blendate.app) See what data we collect in our [Privacy Policy](https://blendate.app).")
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .padding(.vertical, 6)
            .font(.footnote)
            .foregroundColor(Color.gray)
    }
    
    private func sendEmail() async {
        guard !email.isBlank
            else {
                self.error = AlertError(errorDescription: "Invalid Email", failureReason: "Please enter a valid email address", helpAnchor: "Please")
                return
            }
        var actionCodeSettings: ActionCodeSettings {
            let actionCodeSettings = ActionCodeSettings()
            actionCodeSettings.url = URL(string: "https://blendate.page.link/email")
            actionCodeSettings.handleCodeInApp = true
            actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
            return actionCodeSettings
        }
        
        do {
            try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
            UserDefaults.standard.set(email, forKey: "Email")
            self.error = AlertError(errorDescription: "Email Sent", failureReason: "Please check your email for a link to authenticate and sign in, if you don't have an account one will be created for you")
        } catch {
            self.error = error as? AlertError
            printD(error.localizedDescription)
        }

    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}



