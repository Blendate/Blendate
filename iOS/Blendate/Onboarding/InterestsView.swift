//
//  InterestsView.swift
//  Blendate
//
//  Created by Michael on 6/16/21.
//

import SwiftUI

#warning("FIX THIS and VICES")
struct InterestsView: View {    
    @Binding var interests: [Interests]
    var isFilter: Bool = false
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    @State private var presentAlert = false
        
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
                    ForEach(Interests.allCases, id: \.rawValue) { item in
                        cell(item)
//                        ItemArray($interests, item)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
        
    @ViewBuilder
    func cell(_ interest: Interests) -> some View {
        let active = interests.contains(interest)

        Button {
            interests.tapItem(interest)
        } label: {
            VStack{
                Text(interest.rawValue)
                    .fontWeight(.semibold)
                    .foregroundColor(active ? Color.white : Color.DarkBlue )
                Text(interest.subString)
                    .font(.callout)
                    .foregroundColor(active ? .LightGray5:.gray)

            }
            .padding()
            .background(active ? Color.Blue : Color.white)
            .cornerRadius(18)
            .shadow(color: .Blue, radius: 1, x: 0, y: 1)
        }
    }
    
}


//struct InterestView_Previews: PreviewProvider {
//    static var previews: some View {
//        PreviewSignup(path: .interests)
//    }
//}
