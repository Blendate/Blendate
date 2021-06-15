//
//  RelationshipView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct RelationshipView: View {
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
            Text("Relationship Status")
                .font(.custom("Montserrat-SemiBold", size: 32))
                .foregroundColor(.Blue)
                .multilineTextAlignment(.center)
                .frame(width: 350, alignment: .center)
            HStack{
                ItemButton(title: "Single", active: user.relationship == .single){
                    user.relationship = .single
                    next.toggle()
                }.padding(.trailing)
                
                ItemButton(title: "Seperated", active: user.relationship == .separated){
                    user.relationship = .separated
                    next.toggle()
                }
            }
            HStack{
                ItemButton(title: "Divorced", active: user.relationship == .divorced){
                    user.relationship = .divorced
                    next.toggle()
                }.padding(.trailing)
                
                ItemButton(title: "Widowed", active: user.relationship == .widowed){
                    user.relationship = .widowed
                    next.toggle()
                }
            }
            HStack{
                ItemButton(title: "Other", active: user.relationship == .other){
                    user.relationship = .other
                    next.toggle()
                }.padding(.trailing)
            }
            Spacer()
        }
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: false) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: WantKidsView(signup, $user),
                                        isActive: $next,
                                        label: {
                                            NextButton(next: $next, isTop: false)
                                        }
                                    ).disabled(user.relationship == .none))
            .circleBackground(imageName: "Family", isTop: false)
    }
}

struct RelationshipView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RelationshipView(true, .constant(Dummy.user))
        }
    }
}
