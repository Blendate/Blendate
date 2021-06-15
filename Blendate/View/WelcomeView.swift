//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var session: Session
    
    @State var user: User = User(id: "")
    @State private var password: String = ""
    @State private var confirmPass: String = ""
    
    
    func createTapped(){
        
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Pink"), Color("Blue")]), startPoint: .bottomTrailing, endPoint: .topLeading).edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading, spacing: 30) {
                Spacer()
                VStack(alignment: .leading) {
                   Text("Sign Up")
                        .font(.system(size: 28))
                    Text("Fill the form to continue")
                        .font(.system(size: 16))
                }
                VStack(alignment: .leading, spacing: 15) {
                    Text("Email")
                        .font(.system(size: 12))
                    TextField("Email", text: $user.identifier)
                    Text("Password")
                        .font(.system(size: 12))
                    TextField("Password", text: $password)
                    Text("Confirm Password")
                        .font(.system(size: 12))
                    TextField("Confirm Password", text: $confirmPass)
                }
                Spacer()
                HStack{
                    Spacer()
                    Button(action: createTapped){
                        Text("Create Account")
                    }
                    .padding()
                    .background(Color("Blue"))
                    .clipShape(Capsule())
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Or register with")
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {}){
                        Text("Facebook")
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {}){
                        Text("Google")
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                            .foregroundColor(.black)
                    }
                    Button(action: {}){
                        Text("Apple")
                            .padding()
                            .background(Color.white)
                            .clipShape(Capsule())
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Have an account?")
                    Button(action: {}){
                        Text("Login").foregroundColor(.blue)
                    }
                    Spacer()
                }
            }.foregroundColor(.white).padding()
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
