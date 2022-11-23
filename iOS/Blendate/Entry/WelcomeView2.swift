//
//  WelcomeView2.swift
//  Blendate
//
//  Created by Michael on 11/17/22.
//

import SwiftUI

struct WelcomeView2: View {
    @State var siginTapped = false
    var body: some View {
        VStack {
            Spacer()
            header
            Spacer()
            terms
            button
        }
        .padding(.horizontal, 32)
        .background(Color.Blue)
    }
    
    var header: some View {
        VStack {
            HStack() {
                Spacer()
                Image.icon(60, .white)
                Text("Blendate")
                    .fontType(.semibold, 60, .white)
                Spacer()
            }
        }
    }
    
    var button: some View {
        Group {
            if siginTapped {
                signinButtons
            } else {
                accountButtons
            }
        }
    }

    
    var terms: some View {
        Group {
            Text(Self.ByTapping) +
            Text(" [Terms](https://blendate.app) ").fontWeight(.semibold).underline() +
            Text(Self.ProccessData) +
            Text(" [Privacy Policy](https://blendate.app) ").fontWeight(.semibold).underline() +
            Text("and") +
            Text(" [Cookies Policy](https://blendate.app) ").fontWeight(.semibold).underline()
        }
            .multilineTextAlignment(.center)
            .font(.caption2)
            .foregroundColor(Color.white)
            .accentColor(.white)
            .padding(.bottom)
    }
}

extension WelcomeView2 {
    
    var signinButtons: some View {
        VStack {
            SocialSigninButtons()
    //        Rectangle().fill(Color.gray)
                .frame(height:240)
                .noPreview(220, 240, "Social Button")
            Button {
                withAnimation {
                    siginTapped = false
                }
            } label: {
                Text("Back")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }
    
    var accountButtons: some View {
        VStack(spacing: 16) {
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text(Self.Create.uppercased())
                        .fontType(.semibold, 14, .gray)

                    Spacer()
                }
            }
            .padding(12)
            .background(Color.white)
            .clipShape(Capsule())
            Button {
                withAnimation {
                    siginTapped = true
                }
            } label: {
                HStack {
                    Spacer()
                    Text(Self.Signin.uppercased())
                            .fontType(.semibold, 14, .white)
                    Spacer()
                }
            }
            .padding(12)
            .background(Color.clear)
            .clipShape(Capsule())
            .overlay( /// apply a rounded border
                Capsule()
                    .stroke(.white, lineWidth: 2)
            )

        }
        .padding(.bottom)
    }
}

struct WelcomeView2_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView2()
    }
}
