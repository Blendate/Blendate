//
//  PhoneSignInView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/7/23.
//

import SwiftUI
import FirebaseAuth

struct PhoneSigninView: View {
    @EnvironmentObject var navigation: NavigationManager
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
            await signIn(code: otp)
            isLoading = false
            dismiss()
        } else {
            isLoading = true
            await sendVerifyCode(to: phone)
            isLoading = false
            sendTapped = true
        }
    }
    
    func sendVerifyCode(to phone: String) async {
        let phone = "+\(phone)"
        do {
            let verificationID = try await PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil)
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        } catch {
            print(error)
        }

    }
    
    func signIn(code: String) async {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {return}

        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: code
        )
        do {
            let _ = try await navigation.auth.signIn(with: credential)
        } catch {
            print(error)
        }

    }
}


struct PhoneSignInView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneSigninView()
    }
}
