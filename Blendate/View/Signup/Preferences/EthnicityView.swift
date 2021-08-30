//
//  EthnicityView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct EthnicityView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var ethnicity = ""
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                Text("Ethnicity")
                    .font(.custom("Montserrat-SemiBold", size: 32))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                VStack(spacing: 20){
                    HStack{
                        ItemButton(title: "Pacific Islander", width: 160, active: ethnicity == Ethnicity.islander.rawValue){
                            ethnicity = Ethnicity.islander.rawValue
                        }
                        ItemButton(title: "Black/African Descent", width: 180, active: ethnicity == Ethnicity.african.rawValue){
                            ethnicity = Ethnicity.african.rawValue
                        }
                    }
                    HStack{
                        ItemButton(title: "East Asian", active: ethnicity == Ethnicity.eastAsian.rawValue){
                            ethnicity = Ethnicity.eastAsian.rawValue
                        }
                        ItemButton(title: "Hispanic/Latino", width: 180, active: ethnicity == Ethnicity.hispanic.rawValue){
                            ethnicity = Ethnicity.hispanic.rawValue
                        }
                    }
                    HStack{
                        ItemButton(title: "South Asian", active: ethnicity == Ethnicity.southAsian.rawValue){
                            ethnicity = Ethnicity.southAsian.rawValue
                        }
                        ItemButton(title: "Native American", width: 160, active: ethnicity == Ethnicity.indian.rawValue){
                            ethnicity = Ethnicity.indian.rawValue
                        }
                    }
                    HStack{
                        ItemButton(title: "White/Caucasian", width: 160, active: ethnicity == Ethnicity.caucasian.rawValue){
                            ethnicity = Ethnicity.caucasian.rawValue
                        }
                        ItemButton(title: "Middle Eastern", width: 160, active: ethnicity == Ethnicity.middleEast.rawValue){
                            ethnicity = Ethnicity.middleEast.rawValue
                        }
                    }
                    HStack{
                        ItemButton(title: "Other", active: ethnicity == Ethnicity.other.rawValue){
                            ethnicity = Ethnicity.other.rawValue
                        }
                    }
                }.padding()
                Spacer()
                NavigationLink(
                    destination: VicesView(signup),
                    isActive: $next,
                    label: { EmptyView() }
                )
            }
            .offset(y: -30)

            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: true) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                NavNextButton(signup, isTop, save)
            )
            .circleBackground(imageName: nil, isTop: true)
            .onAppear {
                self.ethnicity = state.user?.userPreferences?.ethnicity ?? ""
            }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.ethnicity = ethnicity
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct EthnicityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            EthnicityView(true)
        }
    }
}
