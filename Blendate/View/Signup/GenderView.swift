//
//  GenderView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct GenderView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var gender: String = ""
    
    init(_ signup: Bool = false){
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
                    ItemButton(title: "He/Him", active: gender == Gender.male.rawValue) {
                        gender = Gender.male.rawValue
                    }.padding(.trailing)
                    
                    ItemButton(title: "She/Her", active: gender == Gender.female.rawValue) {
                        gender = Gender.female.rawValue
                    }
                }
                HStack{
                    ItemButton(title: "They/Them", active: gender == Gender.nonBinary.rawValue) {
                        gender = Gender.nonBinary.rawValue
//                        next.toggle()
                    }.padding(.trailing)
                    ItemButton(title: "Other", active: gender == Gender.other.rawValue) {
                        gender = Gender.other.rawValue
//                        next.toggle()
                    }
                }
            }
            NavigationLink(
                destination: ParentView(signup),
                isActive: $next,
                label: { EmptyView() }
            )
        }
        .padding(.bottom, 60)
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: isTop) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: "Gender", isTop: isTop)
        .onAppear {
            self.gender = state.user?.userPreferences?.gender ?? ""
        }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.gender = gender
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}


#if DEBUG
struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            GenderView(true)
                .environmentObject(AppState())
        }
    }
}
#endif

