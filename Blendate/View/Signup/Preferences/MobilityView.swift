//
//  MobilityView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct MobilityView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = false
    
    @State var mobility = ""
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                VStack {
                    Text("Mobility")
                        .blendFont(32, .DarkBlue)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, alignment: .center)
                    ItemButton(title: "Not Willing to Move", width: 200, active: mobility == Mobility.notWilling.rawValue) {
                        mobility = Mobility.notWilling.rawValue
                    }.padding(.bottom)
                    ItemButton(title: "Willing to Move", width: 200, active: mobility == Mobility.willing.rawValue) {
                        mobility = Mobility.willing.rawValue
                    }.padding(.bottom)
                    ItemButton(title: "No Preference", width: 200, active: mobility == Mobility.noPref.rawValue) {
                        mobility = Mobility.noPref.rawValue
                    }
                }.offset(y: -25)
                Spacer()
                
                NavigationLink(
                    destination: ReligionView(signup),
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
            .circleBackground(imageName: "Mobility", isTop: false)
            .onAppear {
                self.mobility = state.user?.userPreferences?.mobility ?? ""
            }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.mobility = mobility
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct MobilityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MobilityView(true)
        }
    }
}
