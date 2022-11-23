//
//  AboutView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct AboutView: View {
    @Binding var about: String
    var isFilter: Bool
    
    init(about: Binding<String>, _ isFilter: Bool = false){
        self._about = about
        self.isFilter = isFilter
        UITextView.appearance().backgroundColor = .clear
    }
    let maxLength: Int = 180
    let isTop = true
    
    var body: some View {
        VStack{
            Text("Tell us about yourself, or share your favorite quote.")
                .fontType(.regular, 20, .DarkBlue)
                .multilineTextAlignment(.center)
                .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.vertical)
            TextEditor(text: $about)
                    .padding()
                    .background(Color.LightGray)
                    .fontType(.regular, 14)
                    .frame(height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(25)
                    .padding()
                .overlay(
                    Text("\(about.count)/\(maxLength)")
                        .foregroundColor(.gray)
                        .font(.caption)
                        .padding(.bottom,20)
                        .padding(.trailing,30)
                        , alignment: .bottomTrailing)
            Spacer()
        }
    }
    
}



struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.bio)
    }
}
