//
//  WelcomeView.swift
//  Blendate
//
//  Created by Michael on 11/17/22.
//

import SwiftUI

#warning("fix phone verification")
struct WelcomeView: View {
    @State var signin = false
    private func signinTapped() { withAnimation { signin = true } }

    var body: some View {
        VStack {
            Header
            Spacer()
            Terms
            if signin {
                SigninButtons
            } else {
               Buttons
            }
        }
        .padding(.horizontal, 32)
        .background(LinearGradient.vertical)
    }
    
    var Header: some View {
        VStack {
            Image.Icon(size: 100, .white)
            Text("Blendate")
                .font(.system(size: 64).weight(.semibold), .white)
//            Text("Find your blended family")
//                .foregroundColor(.white)
//                .font(.title3.weight(.semibold))
        }
        .padding(.top,32)
    }
    
    @ViewBuilder
    var SigninButtons: some View {
        VStack {
            SocialSigninButtons()
                .frame(height:240)
                .noPreview(220, 240, "Social Button")
            Button {
                withAnimation {
                    signin = false
                }
            } label: {
                Text("Back")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }
    
    
    @ViewBuilder
    var Buttons: some View {
        VStack(spacing: 16) {
            AccountButton(title: Self.Create.uppercased(), action: signinTapped)
            AccountButton(title: Self.Signin.uppercased(), background: .clear, text: .white, action: signinTapped)
        }
        .padding(.bottom)
    }
    
    var Terms: some View {
        Group {
            Text("\(Self.ByTapping) ") +
            Text("[Terms and Agreements](https://blendate.app)").fontWeight(.semibold).underline() +
            Text(" \(Self.ProccessData) ") +
            Text("[Privacy Policy](https://blendate.app)").fontWeight(.semibold).underline() +
            Text(" and ") +
            Text("[Cookies Policy](https://blendate.app)").fontWeight(.semibold).underline()
        }
        .multilineTextAlignment(.center)
        .font(.caption2)
        .foregroundColor(.white)
        .accentColor(.white)
        .padding(.bottom)
    }
}

extension WelcomeView {
    struct AccountButton: View {
        let title: String
        var background: Color = .white
        var text: Color = .DarkBlue
        var action: ()->Void
        
        var body: some View {
            if background != .clear {
                button
            } else {
                button
                .overlay(
                    Capsule()
                        .stroke(text, lineWidth: 2)
                )
            }

        }
        
        var button: some View {
            Button(action: action) {
                HStack {
                    Spacer()
                    Text(title)
                        .font(.semibold, text)
                    Spacer()
                }
                .padding(12)
                .background(background)
                .clipShape(Capsule())
            }
        }
    }
    
    struct SigninButton: View {
        let imageName: String
        let title: String
        let color: Color
        var textColor: Color = .white
        var action: ()->Void
        
        var body: some View {
            Button(action: action) {
                HStack {
                    Image(systemName: imageName)
                    Text(title)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal, 8)
                .frame(width: 250, height: 50)
                .background(color)
                .cornerRadius(8)
                .foregroundColor(textColor)
            }
        }
    }
}

struct WelcomeView2_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
