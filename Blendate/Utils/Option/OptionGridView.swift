//
//  OptionGridView.swift
//  Blendate
//
//  Created by Michael on 3/21/22.
//

import SwiftUI

//struct OptionGridView: View {
//    @Binding var user: User
//
//    let gridItems = [GridItem(.flexible()),
//                             GridItem(.flexible())
//                             ]
//    
//    var body: some View {
//        VStack {
//            LazyVGrid(columns: gridItems, spacing: 5) {
//                ForEach((Gender.allCases.dropLast(Gender.allCases.count % 2)), id: \.self) { category in
//                    ItemButton(title: category.title, active: user.details.gender == category) {
//                        user.details.gender = category
//                    }.padding(.trailing)
//                  }
//              }
//              .padding(5)
//            HStack {
//                ForEach(Gender.allCases.suffix(Gender.allCases.count % 2), id: \.self) { category in
//                    ItemButton(title: category.title, active: user.details.gender == category) {
//                        user.details.gender = Gender.male
//                    }.padding(.trailing)
//                }
//            }
//        }
//    }
//}

//struct OptionGridView_Previews: PreviewProvider {
//    static var previews: some View {
//        OptionGridView(user: .constant(dev.michael))
//    }
//}
