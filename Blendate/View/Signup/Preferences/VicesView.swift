//
//  VicesView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI
import RealmSwift

struct VicesView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    @State var vices = RealmSwift.List<String>()
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack{
            Text("Vices")
                .blendFont(32, .white)
                .multilineTextAlignment(.center)
                .padding()
            ScrollView{
                VStack(spacing: 20){
                    HStack {
                        ItemButton(title: "Alcohol", active: vices.contains(Vice.alcohol.rawValue)){
                            vices.tapItem(Vice.alcohol.rawValue)
                        }
                        ItemButton(title: "Late night snacker", width: 180, active: vices.contains(Vice.snacker.rawValue)){
                            vices.tapItem(Vice.snacker.rawValue)
                        }
                    }
                    HStack {
                        ItemButton(title: "Marijuana", width: 150, active: vices.contains(Vice.weed.rawValue)){
                            vices.tapItem(Vice.weed.rawValue)
                        }
                        ItemButton(title: "Tobacco", width: 150, active: vices.contains(Vice.smoke.rawValue)){
                            vices.tapItem(Vice.smoke.rawValue)
                        }
                    }
                    HStack {
                        ItemButton(title: "Psycedelics", width: 150, active: vices.contains(Vice.psychs.rawValue)){
                            vices.tapItem(Vice.psychs.rawValue)
                        }
                        ItemButton(title: "Sleeping in", width: 150, active: vices.contains(Vice.sleep.rawValue)){
                            vices.tapItem(Vice.sleep.rawValue)
                        }
                    }
                    HStack {
                        ItemButton(title: "Nail Biter", width: 150, active: vices.contains(Vice.nail.rawValue)){
                            vices.tapItem(Vice.nail.rawValue)
                        }
                        ItemButton(title: "Coffee Drinker", width: 150, active: vices.contains(Vice.coffee.rawValue)){
                            vices.tapItem(Vice.coffee.rawValue)
                        }
                    }
                    HStack {
                        ItemButton(title: "Procrastinator", width: 150, active: vices.contains(Vice.procras.rawValue)){
                            vices.tapItem(Vice.procras.rawValue)
                        }
                        ItemButton(title: "Chocolate", width: 150, active: vices.contains(Vice.chocolate.rawValue)){
                            vices.tapItem(Vice.chocolate.rawValue)
                        }
                    }
                    HStack {
                        ItemButton(title: "Sun tanning", width: 150, active: vices.contains(Vice.tanning.rawValue)){
                            vices.tapItem(Vice.tanning.rawValue)
                        }
                        ItemButton(title: "Gambling", width: 150, active: vices.contains(Vice.gambling.rawValue)){
                            vices.tapItem(Vice.gambling.rawValue)
                        }
                    }
                    HStack {
                        ItemButton(title: "Shopping", width: 150, active: vices.contains(Vice.shopping.rawValue)){
                            vices.tapItem(Vice.shopping.rawValue)
                        }
                        ItemButton(title: "Excercising", width: 150, active: vices.contains(Vice.excersize.rawValue)){
                            vices.tapItem(Vice.excersize.rawValue)
                        }
                    }
                    HStack {
                        ItemButton(title: "Book Worm", width: 150, active: vices.contains(Vice.books.rawValue)){
                            vices.tapItem(Vice.books.rawValue  )
                        }
                    }
                }
            }.padding()
            if signup {
                CapsuleButton(isActive: .constant(true), title: "Start Blending", action: {
                    state.currentView = .session
                }).padding()
            }
        }
        .offset(y: -40)
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                }
                            ,trailing:
                                Button(action: {state.currentView = .session}) {
                                    Text(signup ? "Done":"")
                                        .bold()
                                        .blendFont(16, .white)
                                }
        )
        .circleBackground(imageName: nil, isTop: true)
        .onAppear {
            self.vices = state.user?.userPreferences?.vices ?? RealmSwift.List<String>()
        }
        
    }
    
    func save(){
//        do {
//            try userRealm.write {
//                state.user?.preferences?.vices = vices
//            }
//        } catch {
//            state.error = "Unable to open Realm write transaction"
//        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
    
}

struct VicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            VicesView(true)
        }
    }
}
