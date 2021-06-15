//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var session: Session
    
//    @State var user: User = User(id: "")
    @State private var password: String = ""
    @State private var confirmPass: String = ""
    @State private var alert = false
    @State private var showSignup = false
    
    func emailTapped(){
//        showSignup = true
        session.currentView = .onboarding
    }
    
    func loginTapped(){
        showSignup = true
    }
    
    func createTapped(){
        
    }
    
    func facebookTapped(){
        
    }
    
    func googleTapped(){
        
    }
    
    func appleTapped(){
        
    }
    
    
    var loginCard: some View {
        VStack(spacing: 40){
            VStack{
                TextField("Email", text: $session.user.identifier)
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.DarkBlue)
            }.padding([.top, .horizontal])
            CapsuleButton(isActive: .constant(true), title: "Create Account", action: createTapped)
                .padding()
                .shadow(radius: 15)
            HStack {
                Spacer()
                Text("Or register with")
                    .foregroundColor(.LightBlue)
                Spacer()
            }
            VStack{
                HStack {
                    LoginButton(title: "Facebook", action: facebookTapped)
                    LoginButton(title: "Google", action: googleTapped)
                }.padding(.bottom)
                HStack {
                    LoginButton(title: "Apple", action: appleTapped)
                    LoginButton(title: "Email", action: emailTapped)
                }
            }.padding()
        }.background(Color.white)
        .cornerRadius(16)
    }
    
    var body: some View {
//        NavigationView {
            VStack(alignment: .center) {
                Spacer()
                Text("Sign Up")
                    .bold()
                    .blendFont(32, .white)
                loginCard
                    .padding()
                    .shadow(radius: 10)
                
                HStack {
                    Text("Have an account?")
                        .foregroundColor(.gray)
                    Button("Log In") {
                        loginTapped()
                    }.foregroundColor(.Blue)
                }
                Spacer()
            }
            .circleBackground(imageName: "", isTop: true)
            .alert(isPresented: $alert, content: {
                Alert(title: Text("Please enter an email address"))
                
            })
//            .sheet(isPresented: $showSignup, content: {
//                SignupView()
//            })
//        }
    }
}


struct LoginButton: View {
    let title: String
    var action: ()->Void
    
    var body: some View {
        Button(action: action){
            HStack {
                Group {
                    switch title {
                    case "Facebook":
                        Image("logo_facebook")
                    case "Google":
                        Image("logo_google")
                    case "Apple":
                        Image(systemName: "applelogo")
                    case "Email":
                        Image(systemName: "envelope")
                    default:
                        Image(systemName: "envelope")
                    }
                }
                .padding()
                Text(title)
                    .padding(.trailing)
            }
            .frame(width: 160)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView().environmentObject(Session())
    }
}
