//
//  NameView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct NameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var active: Bool {
        get { !(user.firstName.isEmpty || user.lastName.isEmpty) }
    }
    
    let signup: Bool
    
    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
        VStack{
            Text("What is your Name")
                .font(.custom("LexendDeca-Regular", size: 32))
                .foregroundColor(.white)
                .padding(.top, 70)
            TFView(placeholder: "First Name", field: $user.firstName)
            TFView(placeholder: "Last Name", field: $user.lastName)
            Text("Last names help build authenticity and will only be shared with matches.")
                .font(.custom("Montserrat-Italic", size: 12))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 300,  alignment: .center)
            Spacer()
            NavigationLink(
                destination: BirthdayView(signup, $user),
                label: {
                    ZStack{
                        Capsule()
                            .foregroundColor(.Blue)
                            .frame(width: 180, height: 48, alignment: .center)
                        Text("Next")
                            .font(.custom("Montserrat-Regular", size: 16))
                            .foregroundColor(.white)
                    }
                }).disabled(user.firstName.isEmpty)
            
            Spacer()
        }
        .circleBackground(imageName: "", isTop: true)
    }
}

struct TFView: View {
    var placeholder:String
    @Binding var field : String
    var body: some View {
        TextField(placeholder, text: $field)
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .center)
            .font(.custom("Montserrat-Italic", size: 14))
            .background(Rectangle()
                            .foregroundColor(.white)
                            .frame( height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .offset( y: 15))
            .padding(10)
    }
}

#if DEBUG
struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NameView(true, .constant(Dummy.user))
        }
    }
}
#endif

