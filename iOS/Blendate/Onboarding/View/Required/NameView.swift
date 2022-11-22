//
//  NameView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct NameView: View {
    @Binding var firstname: String
    @Binding var lastname: String
    
    var body: some View {
        VStack{
            TFView(placeholder: "First Name", field: $firstname)
            TFView(placeholder: "Last Name", field: $lastname)
            Text("Last names help build authenticity and will only be shared with matches.")
                .fontType(.regular, 12, .gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 60)
            Spacer()
        }
        .padding(.top)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(systemName: "chevron.left", action: FirebaseManager.instance.signout)
            }
        }
    }
}

struct TFView: View {
    
    var placeholder:String
    @Binding var field : String
    
    var body: some View {
        TextField(placeholder, text: $field)
            .foregroundColor(.Blue)
            .frame(width: UIScreen.main.bounds.width * 0.8, alignment: .center)
            .background(Rectangle()
                            .foregroundColor(.DarkBlue)
                            .frame( height: 1, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .offset( y: 15))
            .padding(10)
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NameView(
                firstname: .constant(dev.details.firstname),
                lastname:.constant(dev.details.firstname)
            )
        }
        NameView(
            firstname: .constant(dev.details.firstname),
            lastname:.constant(dev.details.firstname)
        )
    }
}

