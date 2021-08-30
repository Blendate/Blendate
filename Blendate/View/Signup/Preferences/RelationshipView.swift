//
//  RelationshipView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct RelationshipView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var relationship = ""
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack{
            Text("Relationship Status")
                .font(.custom("Montserrat-SemiBold", size: 32))
                .foregroundColor(.Blue)
                .multilineTextAlignment(.center)
                .frame(width: 350, alignment: .center)
            HStack{
                ItemButton(title: "Single", active: relationship == Status.single.rawValue){
                    relationship = Status.single.rawValue
                }.padding(.trailing)
                
                ItemButton(title: "Seperated", active: relationship == Status.separated.rawValue){
                    relationship = Status.separated.rawValue
                }
            }
            HStack{
                ItemButton(title: "Divorced", active: relationship == Status.divorced.rawValue){
                    relationship = Status.divorced.rawValue
                }.padding(.trailing)
                
                ItemButton(title: "Widowed", active: relationship == Status.widowed.rawValue){
                    relationship = Status.widowed.rawValue
                }
            }
            HStack{
                ItemButton(title: "Other", active: relationship == Status.other.rawValue){
                    relationship = Status.other.rawValue
                }.padding(.trailing)
            }
            Spacer()
            NavigationLink(
                destination: WantKidsView(signup),
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
        .circleBackground(imageName: "Relationship", isTop: false)
        .onAppear {
            self.relationship = state.user?.userPreferences?.relationship ?? ""
        }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.relationship = relationship
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct RelationshipView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            RelationshipView(true)
        }
    }
}
