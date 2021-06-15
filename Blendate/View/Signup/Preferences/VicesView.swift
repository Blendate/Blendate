//
//  VicesView.swift
//  Blendate
//
//  Created by Michael on 6/7/21.
//

import SwiftUI

struct VicesView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var next: Bool = false
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    func signupUser(){
        print(try! user.toDic())
        API.Auth.signUpGuest(user: user) { uid in
            print("Signed Up \(uid)")
//            API.User.saveImages(uid: uid, profileImage: session.profileImage!, coverPhoto: session.coverPhoto!, images: session.images) { (urls) in
//                print("uploaded")
////                next.toggle()
//            } onError: { (errMsg) in
//                print(errMsg)
//            }
//            next.toggle()
        } onError: { (errMsg) in
            print(errMsg)
        }
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
                        ItemButton(title: "Alcohol", active: user.vices.contains(.alcohol)){
                            user.vices.tapItem(.alcohol)
                            next.toggle()
                        }
                        ItemButton(title: "Late night snacker", width: 180, active: user.vices.contains(.snacker)){
                            user.vices.tapItem(.snacker)
                            next.toggle()
                        }
                    }
                    HStack {
                        ItemButton(title: "Marijuana", width: 150, active: user.vices.contains(.weed)){
                            user.vices.tapItem(.weed)
                            next.toggle()
                        }
                        ItemButton(title: "Tobacco", width: 150, active: user.vices.contains(.smoke)){
                            user.vices.tapItem(.smoke)
                            next.toggle()
                        }
                    }
                    HStack {
                        ItemButton(title: "Psycedelics", width: 150, active: user.vices.contains(.psychs)){
                            user.vices.tapItem(.psychs)
                            next.toggle()
                        }
                        ItemButton(title: "Sleeping in", width: 150, active: user.vices.contains(.sleep)){
                            user.vices.tapItem(.sleep)
                            next.toggle()
                        }
                    }
                    HStack {
                        ItemButton(title: "Nail Biter", width: 150, active: user.vices.contains(.nail)){
                            user.vices.tapItem(.nail)
                            next.toggle()
                        }
                        ItemButton(title: "Coffee Drinker", width: 150, active: user.vices.contains(.coffee)){
                            user.vices.tapItem(.coffee)
                            next.toggle()
                        }
                    }
                    HStack {
                        ItemButton(title: "Procrastinator", width: 150, active: user.vices.contains(.procras)){
                            user.vices.tapItem(.procras)
                            next.toggle()
                        }
                        ItemButton(title: "Chocolate", width: 150, active: user.vices.contains(.chocolate)){
                            user.vices.tapItem(.chocolate)
                            next.toggle()
                        }
                    }
                    HStack {
                        ItemButton(title: "Sun tanning", width: 150, active: user.vices.contains(.tanning)){
                            user.vices.tapItem(.tanning)
                            next.toggle()
                        }
                        ItemButton(title: "Gambling", width: 150, active: user.vices.contains(.gambling)){
                            user.vices.tapItem(.gambling)
                            next.toggle()
                        }
                    }
                    HStack {
                        ItemButton(title: "Shopping", width: 150, active: user.vices.contains(.shopping)){
                            user.vices.tapItem(.shopping)
                            next.toggle()
                        }
                        ItemButton(title: "Excercising", width: 150, active: user.vices.contains(.excersize)){
                            user.vices.tapItem(.excersize)
                            next.toggle()
                        }
                    }
                    HStack {
                        ItemButton(title: "Book Worm", width: 150, active: user.vices.contains(.books)){
                            user.vices.tapItem(.books)
                            next.toggle()
                        }
                    }
                }
            }.padding()
            CapsuleButton(isActive: .constant(true), title: "Start Blending", action: {
                signupUser()
            }).padding()
        }
        .navigationBarItems(leading:
                                BackButton(signup: signup, isTop: true) {
                                    mode.wrappedValue.dismiss()
                                },
                             trailing:
                                Button(action: {}) {
                                    Text("Done")
                                        .bold()
                                        .blendFont(16, .white)
                                })
        .circleBackground(imageName: "", isTop: true)
        
    }
    
}

struct VicesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            VicesView(true, .constant(Dummy.user))
        }
    }
}
