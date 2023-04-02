//
//  InterestsView.swift
//  Blendate
//
//  Created by Michael on 6/16/21.
//

import SwiftUI

#warning("FIX THIS and VICES")
struct InterestsView: View {    
    @Binding var interests:[String]?
    var isFilter: Bool = false
    let isSignup: Bool
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]

    @State private var presentAlert = false
        
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, alignment: .center) {
//                    ForEach(Interest.self.options, id: \.self) { item in
//                        cell(item)
////                        ItemArray($interests, item)
//                    }
                }
            }
        }
        .padding(.horizontal)
    }
        
//    @ViewBuilder
//    func cell(_ interest: Interest) -> some View {
//        let active = interests?.contains(interest.id) ?? false
//
//        Button {
//            interests?.tapItem(interest.id)
//        } label: {
//            VStack{
//                Text(interest.title)
//                    .font(.semibold, 16, active ? .white:.DarkBlue)
//                Text(interest.subString)
//                    .font(.regular, 12, active ? .LightGray5:.gray)
//
//            }
//            .padding()
//            .background(active ? Color.Blue:Color.white)
//            .cornerRadius(18)
//            .shadow(color: .Blue, radius: 1, x: 0, y: 1)
//        }
//    }
    
}


struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(path: .interests)
    }
}

//enum Interest: String, CaseIterable, Property {
//    typealias Value = String
//
//    var title: String {rawValue}
//    case travel = "Travel"
//    case childCare = "ChildCare"
//    case entertainment = "Entertainment"
//    case food = "Food"
//    case entrepreneur = "Entrepreneurship"
//    case international = "International Affair"
//    case art = "Art"
//    case sports = "Sports"
//    case identity = "Identity"
//
//    var subString: String {
//        subtTitles.joined(separator:", ")
//    }
//
//    var subtTitles: [String] {
//        switch self {
//        case .travel:
//            return ["Kid Friendly Hotels","Travel Advice", "Travel Accessories For Kids"]
//        case .childCare:
//            return ["Babysitters", "Childhood Education", "After-School Programs"]
//        case .entertainment:
//            return ["Movies", "Music", "Gaming", "Podcasts", "Celebrities"]
//        case .food:
//            return ["Picky Eaters", "Healthy Recipes", "Veganism", "Vegetarianism"]
//        case .entrepreneur:
//            return ["Stocks", "Small Businesses", "Advice, Hustlers"]
//        case .international:
//            return ["Economics", "Current Events", "Climate", "Social Issues"]
//        case .art:
//            return ["Theater", "Interior Design", "Craft Art", "Dance", "Fashion"]
//        case .sports:
//            return ["Baseball", "Soccer", "Basketball", "Football", "Tennis", "MMA"]
//        case .identity:
//            return ["Special Needs", "Gender Identity", "Puberty", "Birds & Bees"]
//        }
//    }
//}
