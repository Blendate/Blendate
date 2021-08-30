//
//  ReligionView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct ReligionView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var religion = ""
    
    init(_ signup: Bool = false){
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
                    ItemButton(title: "Hindu", width: 100, active: religion == Religion.hindu.rawValue) {
                        religion = Religion.hindu.rawValue
                    }
                    ItemButton(title: "Buddist", width: 100, active: religion == Religion.buddhist.rawValue) {
                        religion = Religion.buddhist.rawValue
                    }
                    ItemButton(title: "Jewish", width: 100, active: religion == Religion.jewish.rawValue) {
                        religion = Religion.jewish.rawValue
                    }
                    
                }
                
                HStack{
                    ItemButton(title: "Christian", width: 100, active: religion == Religion.christian.rawValue) {
                        religion = Religion.christian.rawValue
                    }
                    ItemButton(title: Religion.catholic.rawValue, width: 100, active: religion == Religion.catholic.rawValue) {
                        religion = Religion.catholic.rawValue
                    }
                    ItemButton(title: "Islam", width: 100, active: religion == Religion.islam.rawValue) {
                        religion = Religion.islam.rawValue
                    }
                }
                
                HStack{
                    ItemButton(title: "Atheist/Agnostic", width: 190, active: religion == Religion.atheist.rawValue) {
                        religion = Religion.atheist.rawValue
                    }
                    ItemButton(title: "Chinese Traditional", width: 190, active: religion == Religion.chinese.rawValue) {
                        religion = Religion.chinese.rawValue
                    }
                }
                
                HStack{
                    ItemButton(title: "Muslim", width: 100, active: religion == Religion.muslim.rawValue) {
                        religion = Religion.muslim.rawValue
                    }
                    ItemButton(title: "Sikhism", width: 100, active: religion == Religion.sikhism.rawValue) {
                        religion = Religion.sikhism.rawValue
                    }
                    ItemButton(title: "Other", width: 100, active: religion == Religion.other.rawValue) {
                        religion = Religion.other.rawValue
                    }
                }
                
            }
            NavigationLink(
                destination: PoliticsView(signup),
                isActive: $next,
                label: { EmptyView() }
            )
            
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                            trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: "Religion", isTop: true)
        .onAppear {
            self.religion = state.user?.userPreferences?.religion ?? ""
        }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.religion = religion
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct ReligionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ReligionView(true)
            }
//            .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
