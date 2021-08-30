//
//  WantKidsView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct WantKidsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var familyPlans = ""
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                Spacer()
                Text("Do you want more kids?")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .padding(.top, 65)
                    .multilineTextAlignment(.center)
                    .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(.top, 150)
                
                HStack{
                    ItemButton(title: "Yes", active: familyPlans == FamilyPlans.wantMore.rawValue) {
                        familyPlans = FamilyPlans.wantMore.rawValue
                    }.padding()
                    
                    ItemButton(title:"No", active: familyPlans == FamilyPlans.dontWant.rawValue) {
                        familyPlans = FamilyPlans.dontWant.rawValue
                    }
                }
                ItemButton(title:"Don't Care", width: 150, active: familyPlans == FamilyPlans.dontWant.rawValue) {
                    familyPlans = FamilyPlans.dontWant.rawValue
                }
                
                NavigationLink(
                    destination: WorkView(signup),
                    isActive: $next,
                    label: { EmptyView() }
                )
            }
            .padding(.bottom, 40)
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: true) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavNextButton(signup, isTop, save)
            )
            .circleBackground(imageName: "Family", isTop: true)
            .onAppear {
                self.familyPlans = state.user?.userPreferences?.familyPlans ?? ""
            }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.familyPlans = familyPlans
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

#if DEBUG
struct WantKids_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WantKidsView(true)
        }
    }
}
#endif

