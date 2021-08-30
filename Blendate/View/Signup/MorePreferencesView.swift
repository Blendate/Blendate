//
//  MorePreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 4/19/21.
//

import SwiftUI

struct MorePreferencesView: View {    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    func signupp(){
//        RealmAPI.loginAnon(user: user) {
//            DispatchQueue.main.async {
//                session.currentView = .session
//
//            }
//        } onError: { errMsg in
//            print(errMsg)
//        }
        state.currentView = .session
    }
    
    var body: some View {
        VStack {
            Text("Next Steps")
                .blendFont(32, .DarkBlue)
            Text("Would you like to edit your dating preferences or begin Blending?")
                .blendFont(14, .DarkBlue)
                .multilineTextAlignment(.center)
                .frame(width: 250)
            NavigationLink(
                destination: HeightView(true),
                isActive: $next,
                label: {
                    CapsuleButton(isActive: .constant(true), title: "More Preferences", action: {
                        next.toggle()
                    })
                })
                .padding(.vertical)
                .padding(.horizontal, 60)
            CapsuleButton(isActive: .constant(true), title: "Start Blending", action: {
                signupp()
            }).padding(.horizontal, 60)
            Spacer()
        }.circleBackground(imageName: "Family", isTop: false)
    }
}

#if DEBUG
struct MorePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MorePreferencesView(true)
        }
    }
}
#endif
