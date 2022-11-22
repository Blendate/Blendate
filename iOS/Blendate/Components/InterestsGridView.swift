//
//  InterestsGridView.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import SwiftUI

struct InterestsGridView: View {
    @Binding var interests:[String]

    var body: some View {
        VStack{
            HStack{
                InterestView(interest: Interest.travel, isSelected: interests.contains(Interest.travel.title)) {
                    interests.tapItem(Interest.travel.title)
                }
                InterestView(isLeft: false, interest: Interest.childCare, isSelected: interests.contains(Interest.childCare.title)) {
                    interests.tapItem(Interest.childCare.title)
                }
            }
            HStack{
                InterestView(interest: Interest.entertainment, isSelected: interests.contains(Interest.entertainment.title)) {
                    interests.tapItem(Interest.entertainment.title)
                }
                InterestView(isLeft: false, interest: Interest.food, isSelected: interests.contains(Interest.food.title)) {
                    interests.tapItem(Interest.food.title)
                }
            }
            HStack{
                InterestView(interest: Interest.entrepreneur, isSelected: interests.contains(Interest.entrepreneur.title)) {
                    interests.tapItem(Interest.entrepreneur.title)
                }
                InterestView(isLeft: false, interest: Interest.international, isSelected: interests.contains(Interest.international.title)) {
                    interests.tapItem(Interest.international.title)
                }
            }
            HStack{
                InterestView(interest: Interest.art, isSelected: interests.contains(Interest.art.title)) {
                    interests.tapItem(Interest.art.title)
                }
                InterestView(isLeft: false, interest: Interest.sports, isSelected: interests.contains(Interest.sports.title)) {
                    interests.tapItem(Interest.sports.title)
                }
            }
            HStack{
                InterestView(interest: Interest.identity, isSelected: interests.contains(Interest.identity.title)) {
                    interests.tapItem(Interest.identity.title)
                }
            }
        }
    }
}


struct InterestView: View {
    
    var isLeft = true
    var interest: Interest
    var isSelected : Bool
    var action: ()->Void

    
    var body: some View {
        Button(action: action) {
            ZStack{
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color.white)
                    .frame(width: getRect().width * 0.45, height: 90, alignment: .center)
                
                VStack{
                    Text(interest.title)
                        .font(.custom("Montserrat-Bold", size: 16))
                        .foregroundColor(.DarkBlue)
                    
                    Text(interest.subString)
                        .font(.custom("Montserrat-Regular", size: 12))
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color.gray)
                    
                }
                .frame(width: getRect().width * 0.425, height: 85, alignment: .center)
            }
            .overlay(
                Image(systemName: isSelected ? "checkmark" : "circle")
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.DarkBlue)
                    .clipShape(Circle())
                .offset(x: isLeft ? -15:15, y: 25), alignment: isLeft ? .topLeading:.topTrailing
            )
        }
    }
    
}

struct InterestsGridView_Previews: PreviewProvider {
    static var previews: some View {
        InterestsGridView(interests: .constant(dev.details.interests))
    }
}
