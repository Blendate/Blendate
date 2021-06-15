//
//  ReligionView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct ReligionView: View {
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
            Spacer()
            Text("Religion")
                .font(.custom("Montserrat-SemiBold", size: 32))
                .foregroundColor(.DarkBlue)
                .multilineTextAlignment(.center)
                .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            VStack(spacing: 20){
                HStack{
                    ItemButton(title: "Hindu", width: 100, active: user.religion == .hindu) {
                        user.religion = .hindu
                        next.toggle()
                    }
                    ItemButton(title: "Buddist", width: 100, active: user.religion == .buddhist) {
                        user.religion = .buddhist
                        next.toggle()
                    }
                    ItemButton(title: "Jewish", width: 100, active: user.religion == .jewish) {
                        user.religion = .jewish
                        next.toggle()
                    }
                    
                }
                
                HStack{
                    ItemButton(title: "Christian", width: 100, active: user.religion == .christian) {
                        user.religion = .christian
                        next.toggle()
                    }
                    ItemButton(title: Religion.catholic.rawValue, width: 100, active: user.religion == .catholic) {
                        user.religion = .catholic
                        next.toggle()
                    }
                    ItemButton(title: "Islam", width: 100, active: user.religion == .islam) {
                        user.religion = .islam
                        next.toggle()
                    }
                }
                
                HStack{
                    ItemButton(title: "Atheist/Agnostic", width: 120, active: user.religion == .atheist) {
                        user.religion = .atheist
                        next.toggle()
                    }
                    ItemButton(title: "Chinese Traditional", width: 160, active: user.religion == .chinese) {
                        user.religion = .chinese
                        next.toggle()
                    }
                }
                
                HStack{
                    ItemButton(title: "Muslim", width: 100, active: user.religion == .muslim) {
                        user.religion = .muslim
                        next.toggle()
                    }
                    ItemButton(title: "Sikhism", width: 100, active: user.religion == .sikhism) {
                        user.religion = .sikhism
                        next.toggle()
                    }
                    ItemButton(title: "Other", width: 100, active: user.religion == .other) {
                        user.religion = .other
                        next.toggle()
                    }
                }
                
            }
            
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                            trailing:
                                NavigationLink(
                                    destination: PoliticsView(signup, $user),
                                    isActive: $next,
                                    label: {
                                        NextButton(next: $next, isTop: true)
                                    }
                                ).disabled(user.religion == .none))
        .circleBackground(imageName: "Family", isTop: true)
    }
}

struct ReligionView_Previews: PreviewProvider {
    static var previews: some View {
        ReligionView(true, .constant(Dummy.user))
    }
}
