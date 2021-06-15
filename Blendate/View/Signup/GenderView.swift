//
//  GenderView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct GenderView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    @EnvironmentObject var session: Session
    @State var next: Bool = false
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("I identify as")
                .bold()
                .blendFont(32)
                .multilineTextAlignment(.center)
                .frame(width: 300, alignment: .center)
            VStack(spacing: 30){
                HStack{
                    ItemButton(title: "He/Him", active: user.gender == .male) {
                        user.gender = .male
//                        next.toggle()
                        print(user.gender)
                    }.padding(.trailing)
                    
                    ItemButton(title: "She/Her", active: user.gender == .female) {
                        user.gender = .female
//                        next.toggle()
                    }
                }
                HStack{
                    ItemButton(title: "They/Them", active: user.gender == .nonBinary) {
                        user.gender = .nonBinary
//                        next.toggle()
                    }.padding(.trailing)
                    ItemButton(title: "Other", active: user.gender == .other) {
                        user.gender = .other
//                        next.toggle()
                    }
                }
            }
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                nextButton
        )
        .circleBackground(imageName: "Family", isTop: true)
    }
    
    var nextButton: some View {
        if signup {
            return AnyView(
                NavigationLink(
                    destination: ParentView(signup, $user),
                    label: {
                        NextButton(next: $next, isTop: true)
                    }
                ).disabled(user.gender == .none)
            )
        } else {
            return AnyView(
                Button(action: {}, label: {
                    Text("Save")
                        .foregroundColor(.white)
                })
            )
        }
    }
}


#if DEBUG
struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GenderView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
        NavigationView {
            GenderView(false, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif

