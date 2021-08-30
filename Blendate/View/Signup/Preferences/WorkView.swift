//
//  WorkVew.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct WorkView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = false
    
    @State var workTitle = ""
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("Work")
                    .lexendDeca(.regular, 32)
//                    .font(.custom("Montserrat-SemiBold", size: 32))
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
                
                TextField("", text: $workTitle)
                    .padding(.horizontal)
                
            }
            .frame(width: getRect().width * 0.9, height: 40, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.white)
                    .frame(width: getRect().width * 0.91, height: 41, alignment: .center)
            )

            Spacer()
            NavigationLink(
                destination: EducationView(signup),
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
        .circleBackground(imageName: "Work", isTop: false)
        .onAppear {
            self.workTitle = state.user?.userPreferences?.workTitle ?? ""
        }
        
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.workTitle = workTitle
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}
#if DEBUG
struct WorkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkView(true)
        }
    }
}
#endif
