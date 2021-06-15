//
//  ParenView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct ParentView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var next = false
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Are you a parent?")
                .bold()
                .blendFont(32, .DarkBlue)
            HStack {
                ItemButton(title: "Yes", active: user.isParent) {
                    user.isParent = true
                }
                ItemButton(title: "No", active: !user.isParent) {
                    user.isParent = false
                }
            }.padding(.bottom, 150)
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                NavigationLink(
                                    destination: getDestination(),
                                    isActive: $next,
                                    label: {
                                        NextButton(next: $next, isTop: true)
                                    }
                                ))
        .circleBackground(imageName: "Family", isTop: true)

    }
    
    var navBar: some View {
        HStack {
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            })
            Spacer()
            
            NavigationLink(
                destination: getDestination(),
                isActive: $next,
                label: {
                    Button(action: {
                        next.toggle()
                    }, label: {
                        Text("Next")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundColor(.white)
                    })
                }
            )
        }.padding(.horizontal)
        .padding(.top)
    }
    
    func getDestination() -> AnyView{
        if user.isParent {
            return AnyView(NumberKidsView(signup, $user))
        } else {
            return AnyView(LocationView(signup, $user))
        }
    }
}

#if DEBUG
struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ParentView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif


