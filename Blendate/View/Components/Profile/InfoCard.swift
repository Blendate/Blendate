//
//  InfoCard.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

enum InfoType: String {
    case personal = "Personal"
    case children = "Children"
    case background = "Background"
    case lifestyle = "Lifestyle"

}

struct InfoCard: View {
    let userPreferences: UserPreferences?
    let type: InfoType
    let icon: String
    
    init(_ type: InfoType, _ userPreferences: UserPreferences?){
        self.type = type
        self.userPreferences = userPreferences
        switch type {
        case .personal:
            self.icon = "smiley"
        case .children:
            self.icon = "smiley_child"
        case .background:
            self.icon = "house"
        case .lifestyle:
            self.icon = "blendate"
        }
    }
    
    var body: some View {
        VStack(alignment:.leading){
            HStack {
                Text(type.rawValue)
                    .font(.custom("LexendDeca-Regular.", size: 15))
                Image(icon)
                    .renderingMode(.template)
                    .foregroundColor(.Blue)
//                Image(systemName: "chevron.left")
            }
            switch type {
            case .personal:
                InfoData("Relationship Status", userPreferences?.relationship)
                InfoData("Job Title", userPreferences?.workTitle)
                InfoData("Education", userPreferences?.schoolTitle)
            case .children:
                if userPreferences?.isParent ?? false {
                    InfoData("Parental Status", "Has Children")
                    InfoData("# of Children", "\(userPreferences?.children ?? 0)")
                    InfoData("Children's Age Range", "\(userPreferences?.childAgeMin ?? 0) - \(userPreferences?.childAgeMax ?? 0)")
                }
               
                InfoData("Family Plans", userPreferences?.familyPlans)
            case .background:
                InfoData("Religion", userPreferences?.religion)
                InfoData("Political View", userPreferences?.politics)
                InfoData("Ethnicity", userPreferences?.ethnicity)
            case .lifestyle:
                InfoData("Mobility", userPreferences?.mobility)
                InfoData("Vices", userPreferences?.vices.first)
            }
        }
        .frame(width: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 0.5, x: 0.5, y: 0.5))
    }
}

struct InfoData: View {

    let title: String
    let info: String?

    init(_ title: String, _ info: String?){
        self.title = title
        self.info = info
    }

    var body: some View {
        if let info = info {
            if info.isEmpty {
                Text("")
            } else {
                VStack(alignment: .leading) {
                    Text(info)
                        .foregroundColor(Color.Blue)
                        .font(.custom("LexendDeca-Regular.", size: 14))
                    Text(title)
                        .font(.custom("LexendDeca-Regular.", size: 12))
                        .foregroundColor(.gray)

                }.padding(.bottom, 10)
            }
        } else {
            Text("")
        }
    }
}
