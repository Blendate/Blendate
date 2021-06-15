//
//  MobilityView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct MobilityView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var next: Bool = false
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                Text("Mobility")
                    .blendFont(32, .DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                ItemButton(title: "Not Willing to Move", width: 200, active: user.mobility == .notWilling) {
                    user.mobility = .notWilling
                    next.toggle()
                }.padding(.bottom)
                ItemButton(title: "Willing to Move", width: 200, active: user.mobility == .willing) {
                    user.mobility = .willing
                    next.toggle()
                }.padding(.bottom)
                ItemButton(title: "No Preference", width: 200, active: user.mobility == .noPref) {
                    user.mobility = .noPref
                    next.toggle()
                }.padding(.bottom)
                Spacer()
              
            }
                .navigationBarItems(leading:
                                        BackButton(signup: signup, isTop: false) {
                                            mode.wrappedValue.dismiss()
                                        },
                                     trailing:
                                        NavigationLink(
                                            destination: ReligionView(signup, $user),
                                            isActive: $next,
                                            label: {
                                                NextButton(next: $next, isTop: false)
                                            }
                                        ).disabled(user.mobility == .none ))
                .circleBackground(imageName: "Mobility", isTop: false)
    }
}

struct MobilityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MobilityView(true, .constant(Dummy.user))
        }
    }
}
