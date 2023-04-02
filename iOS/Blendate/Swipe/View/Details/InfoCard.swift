//
//  InfoCard.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct InfoCardsView: View {
    let user: User
    
    var details: User.Details { user.details}
    var info: Stats { user.info }
    
    var body: some View {
        if !noInfo() {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(DetailGroup.allCases){ type in
                        if type.hasValue(for: user){
                            InfoCard(user: user, type: type)
                        }
                    }
                }.padding()
            }
        }
    }
    
    private func noInfo()->Bool{
        for group in DetailGroup.allCases {
            if group.hasValue(for: user) {
                return false
            }
        }
        return true
    }
    
    
    
    struct InfoCard: View {
        let user: User
        let type: DetailGroup
        
        var body: some View {
            VStack(alignment:.leading){
                HStack {
                    Image(systemName: type.systemImage)
                        .foregroundColor(.DarkBlue)
                    Text(type.rawValue.capitalized)
                        .fixedSize()
                        .font(.semibold, .DarkBlue)
                    Spacer()

                }
                .padding(.bottom, 4)
                ForEach(type.cards, id: \.self) { detail in
                    let info = user.valueLabel(for: detail, false)
                    if !info.isBlank {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(detail.label)
                                .foregroundColor(.gray)
                            Text(info)
                                .foregroundColor(.DarkBlue)
                        }
                        .padding(.bottom, 2)
                    }
                }
            }
            .frame(width: 120, alignment: .center)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5))
        }
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardsView(user: alice)
    }
}

