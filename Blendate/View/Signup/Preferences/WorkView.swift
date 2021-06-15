//
//  WorkVew.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct WorkView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var next: Bool = false
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Work")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: .center)
                
                Text("What is your job title?")
                    .font(.custom("Montserrat-Regular", size: 16))
                    .foregroundColor(.DarkBlue)
                    .padding(.top,5)
                    .multilineTextAlignment(.center)
                    .frame(width: getRect().width * 0.556, alignment: .center)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white)
                
                TextField("", text: $user.workTitle)
                    .padding(.horizontal)
                
            }
            .frame(width: getRect().width * 0.9, height: 40, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white)
                    .frame(width: getRect().width * 0.91, height: 41, alignment: .center)
            )

            Spacer()
            
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: false) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                NavigationLink(
                                    destination: EducationView(signup, $user),
                                    isActive: $next,
                                    label: {
                                        NextButton(next: $next, isTop: false)
                                    }
                                ).disabled(user.workTitle.isEmpty))
        .circleBackground(imageName: "Work", isTop: false)
        
    }
}
#if DEBUG
struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkView(true, .constant(Dummy.user))
        }
    }
}
#endif
