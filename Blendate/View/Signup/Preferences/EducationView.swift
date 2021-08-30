//
//  EducationView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct EducationView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = false
    
    @State var schoolTitle = ""
    
    init(_ signup: Bool = false){
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
            }.padding(.bottom, 40)

            
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .fill(Color.white)
                    
                TextField("", text: $schoolTitle)
                    .padding(.horizontal)
                    
            }
            .frame(width: getRect().width * 0.9, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color(#colorLiteral(red: 0.8280140758, green: 0.8503483534, blue: 0.941247642, alpha: 1)))
                    .frame(width: getRect().width * 0.91, height: 41, alignment: .center)
            )

            Spacer()
            NavigationLink(
                destination: MobilityView(signup),
                isActive: $next,
                label: { EmptyView() }
            )
            
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: false) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: "Education", isTop: false)
        .onAppear {
            self.schoolTitle = state.user?.userPreferences?.schoolTitle ?? ""
        }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.schoolTitle = schoolTitle
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct EducationView_Previews: PreviewProvider {
    static var previews: some View {
        EducationView(true)
    }
}
