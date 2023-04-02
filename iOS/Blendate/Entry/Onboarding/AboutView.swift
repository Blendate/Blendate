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
    }
    let maxLength: Int = 180
    let isTop = true
    
    var body: some View {
        VStack{
            Text("Tell us about yourself, or share your favorite quote.")
                .font(.title.weight(.semibold), .DarkBlue)
                .multilineTextAlignment(.center)
                .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding(.vertical)
            TextField("Something nice", text: $about, axis: .vertical)
                .lineLimit(6...10)
                .padding()
                .overlay(
                  RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 2)
                    .foregroundColor(Color.Blue.opacity(0.5))
                )
                .padding()
//                .overlay(
//                    Text("\(about.count)/\(maxLength)")
//                        .foregroundColor(.gray)
//                        .font(.caption)
//                        .padding(.bottom,20)
//                        .padding(.trailing,30)
//                        , alignment: .bottomTrailing
//                )
            Spacer()
        }
        .padding(.horizontal)
    }
    
}
