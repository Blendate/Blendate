//
//  SignupView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 2/8/21.
//

import SwiftUI
import RealmSwift

struct WelcomeView: View {
    @EnvironmentObject var state: AppState

    @State private var email = ""
    @State private var password = ""
    @State private var newUser = false
    @State private var alert = (show: false, txt:"")
    
    func emailTapped(){}
    func facebookTapped(){}
    func googleTapped(){}
    func appleTapped(){}
    
    @State var isLoggingIn = false
    @State var realm: Realm?
    
    var loginCard: some View {
        VStack(spacing: 40){
            VStack {
                VStack{
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.DarkBlue)
                }.padding([.top, .horizontal])
                VStack{
                    SecureField("Password", text: $password)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.DarkBlue)
                }.padding([.top, .horizontal])
                CallToActionButton( title: newUser ? "Signup":"Login") {
                    self.userAction(username: self.email, password: self.password)
                }
                .padding(.horizontal)
                .padding(.top)
                .shadow(radius: 15)
                .disabled(isLoggingIn)
                HStack {
                    CheckBox(title: "Register new email", isChecked: $newUser)
                        .padding(.leading)
                    Spacer()
                }
            }
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
            VStack(alignment: .center) {
                if isLoggingIn {
                    ProgressView()
                }
                Spacer()
                Text("Sign Up")
                    .bold()
                    .blendFont(32, .white)
                loginCard
                    .padding()
                    .shadow(radius: 10)
                Spacer()
            }
            .circleBackground(imageName: nil, isTop: true)
            .alert(isPresented: $alert.show, content: {
                Alert(title: Text(alert.txt))
            })
    }
    
    var footer: some View {
        VStack {
            HStack {
                Text("Have an account?")
                    .foregroundColor(.gray)
                Button("Log In") {
                }.foregroundColor(.Blue)
            }
            Button(action: logout){
                Text("Logout")
                    .foregroundColor(.red)
            }
        }
    }
    
    
    private func logout() {
//        print("Logging out")
//        app.currentUser?.logOut()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in
//            }, receiveValue: {
//                state.shouldIndicateActivity = false
//                state.logoutPublisher.send($0)
//            })
//            .store(in: &state.cancellables)
    }
    
    private func userAction(username: String, password: String) {
        guard textFieldValidatorEmail(username) else {alert.txt = "Please enter a valid email";alert.show = true;return}
//        state.shouldIndicateActivity = true
        isLoggingIn = true
        if newUser {
            signup(username: username, password: password)
        } else {
            login(username: username, password: password)
        }
    }

    private func signup(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
//            state.shouldIndicateActivity = false
            return
        }
        self.state.error = nil
        app.emailPasswordAuth.registerUser(email: username, password: password) { result in
            login(username: username, password: password)
        }
//        app.emailPasswordAuth.registerUser(email: username, password: password)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: {
//                state.shouldIndicateActivity = false
//                switch $0 {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self.state.error = error.localizedDescription
//                }
//            }, receiveValue: {
//                self.state.error = nil
//                login(username: username, password: password)
//            })
//            .store(in: &state.cancellables)
    }

    private func login(username: String, password: String) {
        if username.isEmpty || password.isEmpty {
//            state.shouldIndicateActivity = false
            return
        }
        
        app.login(credentials: .emailPassword(email: username, password: password)) { result in
            if case let .failure(error) = result {
                print("Failed to log in: \(error.localizedDescription)")
                // Set error to observed property so it can be displayed
//                self.error = error
                return
            }
            // Other views are observing the app and will detect
            // that the currentUser has changed. Nothing more to do here.
            print("Logged in")
        }
//        self.state.error = nil
//        app.login(credentials: .emailPassword(email: username, password: password))
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: {
//                state.shouldIndicateActivity = false
//                isLoggingIn = false
//                print("Logged in")
//                switch $0 {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self.state.error = error.localizedDescription
//                }
//            }, receiveValue: {
//                self.state.error = nil
//                print($0.id)
//                state.loginPublisher.send($0)
//            })
//            .store(in: &state.cancellables)
    }
    
    
    
    
    func textFieldValidatorEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
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

struct CallToActionButton: View {
    let title: String
    var showingArrow = false
    let action: () -> Void

    private enum Dimensions {
        static let labelSpacing: CGFloat = 14
        static let lineLimit = 1
        static let radius: CGFloat = 50.0
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer(minLength: Dimensions.labelSpacing)
                Text(LocalizedStringKey(title))
                    .padding(.vertical, Dimensions.labelSpacing)
                    .lineLimit(Dimensions.lineLimit)
                    .font(Font.body.weight(.semibold))
                if showingArrow {
                    Image(systemName: "arrow.right")
                        .font(Font.caption2.weight(.bold))
                }
                Spacer(minLength: Dimensions.labelSpacing)
            }
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(Dimensions.radius)
        }
    }
}

struct CheckBox: View {
    var title: String
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: { self.isChecked.toggle() }) {
            HStack {
                Image(systemName: isChecked ? "checkmark.square": "square")
                Text(title)
            }
            .foregroundColor(isChecked ? .primary : .secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(AppState())
    }
}
