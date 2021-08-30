//
//  ParenView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct ParentView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    @State var isParent: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            Text("Are you a parent?")
                .bold()
                .blendFont(32, .DarkBlue)
            HStack {
                ItemButton(title: "Yes", active: isParent) {
                    isParent = true
                }
                ItemButton(title: "No", active: !isParent) {
                    isParent = false
                }
            }.padding(.bottom, 100)
            NavigationLink(
                destination: getDestination(),
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
        .circleBackground(imageName: "Family", isTop: true)
        .onAppear {
            self.isParent = state.user?.userPreferences?.isParent ?? false
        }
    }

    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.isParent = isParent
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
    
    var navBar: some View {
        HStack {
            Button(action: {
                self.mode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            })
            Spacer()
            
            NavigationLink(
                destination: getDestination(),
                isActive: $next,
                label: {
                    Button(action: {
                        next.toggle()
                    }, label: {
                        Text(signup ? "Next":"")
                            .font(.custom("Montserrat-Bold", size: 16))
                            .foregroundColor(.white)
                    })
                }
            )
        }.padding(.horizontal)
        .padding(.top)
    }
    
    func getDestination() -> AnyView{
        if isParent {
            return AnyView(NumberKidsView(signup))
        } else {
            return AnyView(LocationView(signup))
        }
    }
}

#if DEBUG
struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ParentView(true)
                .environmentObject(AppState())
        }
    }
}
#endif


