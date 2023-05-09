//
//  InfoCard.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct InfoCardsView: View {
    let user: User
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                if user.relationship.isValid || user.workTitle.isValid || user.schoolTitle.isValid {
                    InfoCard(user: user, title: "Personal", systemImage: "person.fill") {
                        InfoCell(value: user.relationship)
                        InfoCell(value: user.workTitle)
                        InfoCell(value: user.schoolTitle)
                    }
                }
                InfoCard(user: user, title: "Family", systemImage: "figure.and.child.holdinghands") {
                    InfoCell(value: user.isParent)
                    InfoCell(value: user.children)
                    InfoCell(value: user.childrenRange)
                    InfoCell(value: user.familyPlans)

                }
                if user.religion.isValid || user.politics.isValid {
                    InfoCard(user: user, title: "Background", systemImage: "house") {
                        InfoCell(value: user.religion)
                        InfoCell(value: user.politics)
                    }
                }
                if user.mobility.isValid {
                    InfoCard(user: user, title: "Premium", systemImage: "lock") {
                        InfoCell(value: user.mobility)
                        //                    InfoCell(value: user.vices)
                    }
                }
            }.padding()
        }
    }
    

    
    struct InfoCard<Cards: View>: View {
        let user: User
        let title: String
        let systemImage: String
        
        @ViewBuilder var cards: Cards
        
        var body: some View {
            VStack(alignment:.leading){
                HStack {
                    Image(systemName: systemImage)
                        .foregroundColor(.DarkBlue)
                    Text(title.capitalized)
                        .fixedSize()
                        .font(.semibold, .DarkBlue)
                    Spacer()

                }
                .padding(.bottom, 4)
                cards
            }
            .frame(width: 120, alignment: .center)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5))
        }
    }
    
    struct InfoCell<P:Property>: View {
        let value: P
        var body: some View {
            if value.isValid {
                VStack(alignment: .leading, spacing: 6) {
                    Text(P.label)
                        .foregroundColor(.gray)
                    Text(value.valueLabel)
                        .foregroundColor(.DarkBlue)
                }
                .padding(.bottom, 2)
            }
        }
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardsView(user: alice)
    }
}

//ForEach(type.cards, id: \.self) { detail in
//    let info = user.valueLabel(for: detail, false)
//    if !info.isBlank {
//        VStack(alignment: .leading, spacing: 6) {
//            Text(detail.label)
//                .foregroundColor(.gray)
//            Text(info)
//                .foregroundColor(.DarkBlue)
//        }
//        .padding(.bottom, 2)
//    }
//}
