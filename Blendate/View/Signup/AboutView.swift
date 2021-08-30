//
//  AboutView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = true
    
    let maxLength: Int = 180
    
    @State var bio: String = ""
    
//    @Binding var user: AppUser {
//        didSet {
//            if user.bio.count > maxLength && oldValue.bio.count <= maxLength {
//                user.bio = oldValue.bio
//            }
//        }
//    }
    
    init(_ signup: Bool = false){
        self.signup = signup
    }
    
    var body: some View {
            VStack{
                VStack {
                    Text("About Me")
                        .font(.custom("Montserrat-SemiBold", size: 32))
                        .foregroundColor(Color.white)
                        .padding(.top, 20)
                        .multilineTextAlignment(.center)
                        .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("Tell us about yourself, or share your favorite quote.")
                        .font(.custom("Montserrat-Regular", size: 18))
                        .foregroundColor(Color.white)
                        .padding(.top,5)
                        .multilineTextAlignment(.center)
                        .frame(width: getRect().width * 0.6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }.padding(.bottom, 30)
                .offset(y: -30)
                TextEditor(text: $bio)
//                TextView(text: $session.user.bio)
                    .font(.custom("Montserrat-Regular", size: 14))
                    .padding(.horizontal)
                    .frame(height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .padding())
                    .overlay(
                        Text("\(bio.count)/\(maxLength)")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding()
                            .padding(.trailing, 10)
                            , alignment: .bottomTrailing)
               
                Spacer()
                
                NavigationLink(
                    destination: AddPhotosView(signup),
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
            .circleBackground(imageName: nil, isTop: true)
            .onAppear {
                self.bio = state.user?.userPreferences?.bio ?? ""
            }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.bio = bio
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
}

struct TextView: UIViewRepresentable {
 
    @Binding var text: String
 
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
 
        textView.font = UIFont(name: "Montserrat-Regular", size: 12)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        
        return textView
    }
 
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = UIFont(name: "Montserrat-Regular", size: 12)
    }
}

#if DEBUG
struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AboutView(true)
                .environmentObject(AppState())
        }
    }
}
#endif
