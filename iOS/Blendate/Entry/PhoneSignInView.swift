//
//  PhoneSignInView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/7/23.
//

import SwiftUI

struct PhoneSigninView: View {
    @EnvironmentObject var authManager: FirebaseAuthState
    @Environment(\.dismiss) private var dismiss

    @State private var phone: String = ""
    @State private var otp: String = ""
    @State private var sendTapped = false
    
    @State private var isLoading = false
    
    var buttonTitle: String { sendTapped ? "Verify":"Send Code"}
    
    var body: some View {
        ZStack {
            Color.indigo.ignoresSafeArea()
            VStack {
                HStack {
                    Text("+1")
                        .font(.title2.weight(.semibold))
                        .foregroundColor(.white)
                    TextField("5162129859", text: $phone)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                        .padding()
                        .background (
                            Color.white.cornerRadius(15)
                        )
                        .overlay(
                          RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.gray)
                          )
                        .disabled(sendTapped)
                }
                .padding()
                if sendTapped {
                    TextField("123456", text: $otp)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.phonePad)
                        .padding()
                        .background (
                            Color.white.cornerRadius(15)
                        )
                        .overlay(
                          RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(.gray)
                          )
                        .padding(.horizontal, 32)
                }
                Button {
                    Task {
                        await buttonTapped()
                    }
                } label: {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text(buttonTitle)
                    }
                }

                .font(.title3.weight(.bold))
                .padding()
                .background(Color.white)
                .foregroundColor(.indigo)
                .clipShape(RoundedRectangle(cornerRadius: 10) )
            }
        }
    }
    
    func buttonTapped() async {
        if sendTapped {
            isLoading = true
            await authManager.signIn(code: otp)
            isLoading = false
            dismiss()
        } else {
            isLoading = true
            await authManager.sendVerifyCode(to: phone)
            isLoading = false
            sendTapped = true
        }
    }
}


struct PhoneSignInView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneSigninView()
    }
}
