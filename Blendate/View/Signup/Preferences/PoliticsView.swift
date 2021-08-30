//
//  PoliticsView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct PoliticsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var politics = ""
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                Text("Politics")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(.DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 350, alignment: .center)
                    .padding(.bottom, 40)
                HStack{
                    ItemButton(title:"Liberal", active: politics == Politics.liberal.rawValue){
                        politics = Politics.liberal.rawValue
                    }.padding(.trailing)
                    ItemButton(title: "Conservative", active: politics == Politics.conservative.rawValue){
                        politics = Politics.conservative.rawValue
                    }
                }
                
                HStack{
                    ItemButton(title: "Centrist", active: politics == Politics.centrist.rawValue){
                        politics = Politics.centrist.rawValue
                    }.padding(.trailing)
                    ItemButton(title: "Other", active: politics == Politics.other.rawValue){
                        politics = Politics.other.rawValue
                    }
                }
                Spacer()
                
                NavigationLink(
                    destination: EthnicityView(signup),
                    isActive: $next,
                    label: { EmptyView() }
                )
            }

            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: false) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavNextButton(signup, false, save)
            )
            .circleBackground(imageName: "Politics", isTop: false)
            .onAppear {
                self.politics = state.user?.userPreferences?.politics ?? ""
            }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.politics = politics
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct PoliticsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PoliticsView(true)
        }
    }
}
