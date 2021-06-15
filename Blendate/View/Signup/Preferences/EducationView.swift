//
//  EducationView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct EducationView: View {
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
            VStack {
                Text("Education")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .padding(.top, 40)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("What University, College, or High School did you attend?")
                    .font(.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(.DarkBlue)
                    .padding(.top,5)
                    .multilineTextAlignment(.center)
                    .frame(width: getRect().width * 0.7, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white)
                    
                TextField("", text: $user.schoolTitle)
                    .padding(.horizontal)
                    
            }
            .frame(width: getRect().width * 0.9, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color(#colorLiteral(red: 0.8280140758, green: 0.8503483534, blue: 0.941247642, alpha: 1)))
                .frame(width: getRect().width * 0.91, height: 41, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            )
            Spacer()
          
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: false) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                NavigationLink(
                                    destination: MobilityView(signup, $user),
                                    isActive: $next,
                                    label: {
                                        NextButton(next: $next, isTop: false)
                                    }
                                ).disabled(user.schoolTitle.isEmpty))
        .circleBackground(imageName: "Family", isTop: false)
        
    }
}

struct EducationView_Previews: PreviewProvider {
    static var previews: some View {
        EducationView(true, .constant(Dummy.user))
    }
}
