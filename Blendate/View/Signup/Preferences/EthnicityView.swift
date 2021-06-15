//
//  EthnicityView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct EthnicityView: View {
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
                Text("Ethnicity")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                VStack(spacing: 20){
                    HStack{
                        ItemButton(title: "Pacific Islander", width: 160, active: user.ethnicity == .islander){
                            user.ethnicity = .islander
                            next.toggle()
                        }
                        ItemButton(title: "Black/African Descent", width: 180, active: user.ethnicity == .african){
                            user.ethnicity = .african
                            next.toggle()
                        }
                    }
                    HStack{
                        ItemButton(title: "East Asian", active: user.ethnicity == .eastAsian){
                            user.ethnicity = .eastAsian
                            next.toggle()
                        }
                        ItemButton(title: "Hispanic/Latino", width: 180, active: user.ethnicity == .hispanic){
                            user.ethnicity = .hispanic
                            next.toggle()
                        }
                    }
                    HStack{
                        ItemButton(title: "South Asian", active: user.ethnicity == .southAsian){
                            user.ethnicity = .southAsian
                            next.toggle()
                        }
                        ItemButton(title: "Native American", width: 160, active: user.ethnicity == .indian){
                            user.ethnicity = .indian
                            next.toggle()
                        }
                    }
                    HStack{
                        ItemButton(title: "White/Caucasian", width: 160, active: user.ethnicity == .caucasian){
                            user.ethnicity = .caucasian
                            next.toggle()
                        }
                        ItemButton(title: "Middle Eastern", width: 160, active: user.ethnicity == .middleEast){
                            user.ethnicity = .middleEast
                            next.toggle()
                        }
                    }
                    HStack{
                        ItemButton(title: "Other", active: user.ethnicity == .other){
                            user.ethnicity = .other
                            next.toggle()
                        }
                    }
                }.padding()
                Spacer()
            }
                .navigationBarItems(leading:
                                        BackButton(signup: signup, isTop: true) {
                                            mode.wrappedValue.dismiss()
                                        },
                                     trailing:
                                        NavigationLink(
                                            destination: VicesView(signup, $user),
                                            isActive: $next,
                                            label: {
                                                NextButton(next: $next, isTop: true)
                                            }
                                        ).disabled(user.ethnicity == .none ))
                .circleBackground(imageName: "", isTop: true)
    }
}

struct EthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            EthnicityView(true, .constant(Dummy.user))
        }
    }
}
