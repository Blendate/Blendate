////
////  MorePreferencesView.swift
////  Blendate
////
////  Created by Michael Wilkowski on 4/19/21.
////
//
//import SwiftUI
//
//struct MorePreferencesView: View {
//
//    @Binding var user: User
//    init(_ user: Binding<User>){ self._user = user }
//    @State var next: Bool = false
//
//    var body: some View {
//        VStack {
//            Text("Next Steps")
//                .fontType(.regular, 32, .DarkBlue)
//                .padding(.bottom)
//            Text("Would you like to edit your dating preferences or begin Blending?")
//                .fontType(.regular, 16)
//                .foregroundColor(.DarkBlue)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 50)
//            NavigationLink(
//                destination: HeightView(height: $user.details.height),
//                isActive: $next,
//                label: {
//                    CapsuleButton(isActive: .constant(true), title: "More Preferences", action: {
//                        next.toggle()
//                    })
//                })
//                .padding(.vertical)
//                .padding(.horizontal, 60)
//            CapsuleButton(isActive: .constant(true), title: "Start Blending", action: {
//                creasteUserDoc()
//            }).padding(.horizontal, 60)
//            Spacer()
//        }
////        .elipseBackground(false)
//    }
//    
//    private func creasteUserDoc() {
//        do {
//            try UserService().createDoc(from: user)
//            user.settings.onboarded = true
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
//
//#if DEBUG
//struct MorePreferencesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            MorePreferencesView(.constant(dev.michael))
//        }
//    }
//}
//#endif
