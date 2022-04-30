//
//  EmailSigninView.swift
//  Blendate
//
//  Created by Michael on 3/20/22.
//

import SwiftUI
import FirebaseAuth

struct EmailSigninView: View {
    @Environment(\.dismiss) private var dismiss
    @State var email: String = ""
    @State var password: String = ""
    @State private var isLoading = false
    var body: some View {
        NavigationView {
            VStack{
                Image.icon(75)
                    .padding(.vertical)
                emailfield
                passwordfield
                capsuleButton
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    var capsuleButton: some View {
        AsyncButton("Sign in") {
            await signin()
        }
        .capsuleButton(fontsize: 18)
    }

    
    var emailfield: some View {
        VStack {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.vertical)
                .padding(.horizontal, 6)
                .background(.white)
                .cornerRadius(16)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.Blue)
                .offset(y: -20)
        }
        .padding(.horizontal)
    }
    
    var passwordfield: some View {
        VStack {
            SecureField("Password", text: $password)
                .foregroundColor(.DarkBlue)
                .padding(.vertical)
                .padding(.horizontal, 6)
                .background(.white)
                .cornerRadius(16)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.Blue)
                .padding(.bottom)
                .offset(y: -20)
        }
        .padding(.horizontal)
    }
    
    func signin() async {
        let firebase = FirebaseManager.instance
        do {
            try await firebase.auth.signIn(withEmail: email, password: password)
        } catch {
            if !userExists(error) {
                do {
                    let _ = try await firebase.auth.createUser(withEmail: email, password: password)
//                    try await firebase.auth.createUser(withEmail: email, password: password)
                } catch {
                    printD( FirebaseError.generic("There was an problem creating your accout, please try again and if the problem persists contact support") )
                }
            }else {
                printD( FirebaseError.server)
            }

        }
    }

    private func userExists(_ error: Error)->Bool{
        if let errCode = AuthErrorCode(rawValue: error._code), errCode == .userNotFound {
            return false
        } else {
            return true
        }
    }

}

struct EmailSigninView_Previews: PreviewProvider {
    static var previews: some View {
        EmailSigninView()
    }
}
