//
//  InterestedView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct InterestedView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var seeking: String = ""
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                Spacer()
                Text("Who are you interested in dating?")
                    .montserrat(.semibold, 32)
                    .foregroundColor(.DarkBlue)
                    .multilineTextAlignment(.center)
                    .frame(width: 350, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                HStack{
                    ItemButton(title: "Women", width: 136, active: seeking == Gender.female.rawValue) {
                        seeking = Gender.female.rawValue
                    }.padding()
                    ItemButton(title: "Men", width: 136, active: seeking == Gender.male.rawValue) {
                        seeking = Gender.male.rawValue
                    }
                }
                
                HStack{
                    ItemButton(title: "Both", width: 136, active: seeking == Gender.nonBinary.rawValue) {
                        seeking = Gender.other.rawValue
                    }
                    
                }
                NavigationLink(
                    destination: RelationshipView(signup),
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
            .circleBackground(imageName: "Interested", isTop: true)
            .onAppear {
                self.seeking = state.user?.userPreferences?.seeking ?? ""
            }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.seeking = seeking
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}


#if DEBUG
struct InterestedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InterestedView(true)
                .environmentObject(AppState())
        }
    }
}
#endif
