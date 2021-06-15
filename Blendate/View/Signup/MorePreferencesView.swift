//
//  MorePreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 4/19/21.
//

import SwiftUI

struct MorePreferencesView: View {
    @EnvironmentObject var session: Session

    @State var next = false
    
    @Binding var user: User

    init(_ user: Binding<User>){
        self._user = user
    }
    
    func signup(){


        API.Auth.signUpGuest(user: session.user) { uid in
            print("Signed Up \(uid)")
//            API.User.saveImages(uid: uid, profileImage: session.profileImage!, coverPhoto: session.coverPhoto!, images: session.images) { (urls) in
//                print("uploaded")
////                next.toggle()
//            } onError: { (errMsg) in
//                print(errMsg)
//            }
//            next.toggle()
        } onError: { (errMsg) in
            print(errMsg)
        }
    }
    
    var body: some View {
        VStack {
            Text("Next Steps")
                .blendFont(32, .DarkBlue)
            Text("Would you like to edit your  dating preferences or begin Blending?")
                .blendFont(14, .DarkBlue)
                .multilineTextAlignment(.center)
                .frame(width: 250)
            NavigationLink(
                destination: HeightView(true, $user),
                isActive: $next,
                label: {
                    CapsuleButton(isActive: .constant(true), title: "More Preferences", action: {
                        next.toggle()
                    })
                })
                .padding(.vertical)
                .padding(.horizontal, 60)
            CapsuleButton(isActive: .constant(true), title: "Start Blending", action: {
                signup()
            }).padding(.horizontal, 60)
            Spacer()
        }.circleBackground(imageName: "Family", isTop: false)
    }
}

#if DEBUG
struct MorePreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MorePreferencesView(.constant(Dummy.user))
        }
    }
}
#endif
