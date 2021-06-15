//
//  AboutView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct AboutView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let signup: Bool
    @State private var next = false
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
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
                }
                TextEditor(text: $user.bio)
//                TextView(text: $session.user.bio)
                    .font(.custom("Montserrat-Regular", size: 14))
                    .padding(.horizontal)
                    .frame(height: 130, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .padding())
                    .overlay(
                        Text("0/180")
                            .foregroundColor(.gray)
                            .font(.caption)
                            .padding()
                            .padding(.trailing, 10)
                            , alignment: .bottomTrailing)
               
                Spacer()
               
            }
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: true) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: AddPhotosView(signup, $user),
                                        isActive: $next,
                                        label: {
                                            NextButton(next: $next, isTop: true)
                                        }
                                    ).disabled(user.bio.isEmpty))//.disabled(session.user.bio.isEmpty)
            .circleBackground(imageName: "", isTop: true)
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
            AboutView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif
