//
//  PoliticsView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct PoliticsView: View {
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
                Text("Politics")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 350, alignment: .center)
                HStack{
                    ItemButton(title:"Liberal", active: user.politics == .liberal){
                        user.politics = .liberal
                        next.toggle()
                    }.padding(.trailing)
                    ItemButton(title: "Conservative", active: user.politics == .conservative){
                        user.politics = .conservative
                        next.toggle()
                    }
                }
                
                HStack{
                    ItemButton(title: "Centrist", active: user.politics == .centrist){
                        user.politics = .centrist
                        next.toggle()
                    }.padding(.trailing)
                    ItemButton(title: "Other", width: 180, active: user.politics == .other){
                        user.politics = .other
                        next.toggle()
                    }
                }
                Spacer()
            }
                .navigationBarItems(leading:
                                        BackButton(signup: signup, isTop: false) {
                                            mode.wrappedValue.dismiss()
                                        },
                                     trailing:
                                        NavigationLink(
                                            destination: EthnicityView(signup, $user),
                                            isActive: $next,
                                            label: {
                                                NextButton(next: $next, isTop: false)
                                            }
                                        ).disabled(user.politics == .none))
                .circleBackground(imageName: "Politics", isTop: false)
    }
}

struct PoliticsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PoliticsView(true, .constant(Dummy.user))
        }
    }
}
