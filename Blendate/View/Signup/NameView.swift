//
//  NameView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct NameView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let isTop = true
    let signup: Bool
    
    @State var firstName = ""
    @State var lastName = ""
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
        VStack{
            Text("What is your Name")
                .font(.custom("LexendDeca-Regular", size: 32))
                .foregroundColor(.white)
                .padding(.top, 70)
            TFView(placeholder: "First Name", field: $firstName)
                .onChange(of: firstName, perform: { value in
//                    try? userRealm.write {
//                        state.user?.preferences?.firstName = value
//                    }
                })
            TFView(placeholder: "Last Name", field: $lastName)
                .onChange(of: lastName, perform: { value in
//                    try? userRealm.write {
//                        state.user?.preferences?.lastName = value
//                    }
                })
            Text("Last names help build authenticity and will only be shared with matches.")
                .montserrat(.italic, 12)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 300,  alignment: .center)
            Spacer()
            NavigationLink(
                destination: BirthdayView(signup),
                isActive: $next,
                label: {
                    CapsuleButton(isActive: .constant(true), title: "Next", color: .Blue, action: save)
                            .padding(.horizontal)
                            .frame(width: 180, height: 48, alignment: .center)

//                        Capsule()
//                            .foregroundColor(.Blue)
//                            .frame(width: 180, height: 48, alignment: .center)
//                        Text("Next")
//                            .montserrat(.regular, 16)
//                            .foregroundColor(.white)
                }).disabled(firstName.isEmpty)
            Spacer()
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: isTop) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                NavNextButton(signup, isTop, save)
        )
        .circleBackground(imageName: nil, isTop: isTop)
        .onAppear {
            self.firstName = state.user?.userPreferences?.firstName ?? ""
            self.lastName = state.user?.userPreferences?.lastName ?? ""

        }
    }
    
    func save(){
        let pref = UserPreferences()
        pref.firstName = firstName
        pref.lastName = lastName
        do {
            if signup {
                try userRealm.write {
                    state.user?.userPreferences = pref
                }
            } else {
                try userRealm.write {
                    state.user?.userPreferences?.firstName = firstName
                    state.user?.userPreferences?.lastName = lastName
                }
            }

        } catch {
            print("Unable to open Realm write transaction")
            state.error = "Unable to open Realm write transaction"
        }
        print("wrote: \(String(describing: state.user?._id))")
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct TFView: View {
    
    var placeholder:String
    @Binding var field : String
    
    var body: some View {
        TextField(placeholder, text: $field)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .center)
            .montserrat(.italic, 14)
            .background(Rectangle()
                            .foregroundColor(.white)
                            .frame( height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .offset( y: 15))
            .placeholder(when: field.isEmpty) {
                    Text(placeholder).foregroundColor(.white)
            }
            .padding(10)

    }
}

#if DEBUG
struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NameView()
                .environmentObject(AppState())
        }
    }
}
#endif

