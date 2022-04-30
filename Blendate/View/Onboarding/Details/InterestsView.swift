//
//  InterestsView.swift
//  Blendate
//
//  Created by Michael on 6/16/21.
//

import SwiftUI

struct InterestsView: View {
    @EnvironmentObject var sessionState: SessionViewModel

    @State var next = false
    @Binding var interests:[String]
    
    @State private var presentAlert = false
    @State private var error: ErrorInfo?
        
    var body: some View {
        VStack{
            InterestsGridView(interests: $interests)
                .padding()
            Spacer()
            Button("Start Blending"){
                creasteUserDoc()
            }
            .fontType(.semibold, 22)
            .tint(.purple)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .padding()
        }.padding(.horizontal)
        .alert(
            isPresented: $presentAlert,
            error: error, // 1
            actions: { error in // 2
                if let suggestion = error.recoverySuggestion {
                    Button(suggestion) {
                        // Recover from an error
                    }
                }
            }, message: { error in // 3
            if let failureReason = error.failureReason {
                Text(failureReason)
            } else if let help = error.helpAnchor {
                Text(help)
            } else {
                Text("Something went wrong")
            }
        })
    }

    
}

extension InterestsView {
    
    private func creasteUserDoc() {
        do {
            var cache = sessionState.user
            cache.settings.onboarded = true
            try createDoc(from: cache)
            sessionState.user = cache
            sessionState.loadingState = .user
        } catch let error as ErrorInfo {
           self.error = error
        } catch {
            self.error = ErrorInfo(errorDescription: "Server Error", failureReason: "There was an error creating your account", recoverySuggestion: "Try again", helpAnchor: error.localizedDescription)
        }
    }
    
    func createDoc(from user: User) throws {
        let uid = try FirebaseManager.instance.checkUID()
        var cache = user
        cache.id = uid
        cache.settings.onboarded = true
        cache.settings.providers = getProviders() ?? []
        //        try LocalFileManager.instance.store(user: user)
        try FirebaseManager.instance.Users.document(uid).setData(from: cache)
    }
    
    func getProviders() -> [Provider]? {
        guard let user = FirebaseManager.instance.auth.currentUser else {return nil }
        
        var providers = [Provider]()
        for i in user.providerData {
            printD("Provider: \(i.providerID)\nEmail: \(i.email ?? "None")")
            if i.providerID != "firebase" || i.providerID != "Firebase"{//.equals("facebook.com")) {
                switch i.providerID {
                case "apple.com":
                    providers.append(Provider(type: .apple, email: i.email) )
                case "facebook.com":
                    providers.append(Provider(type: .facebook, email: i.email) )
                case "google.com":
                    providers.append(Provider(type: .google, email: i.email) )
                case "twitter.com":
                    providers.append(Provider(type: .twitter, email: i.email) )
                default:
                    providers.append(Provider(type: .email, email: i.email) )
                }
            }
        }
        return providers
    }
}


struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.interests)
    }
}
