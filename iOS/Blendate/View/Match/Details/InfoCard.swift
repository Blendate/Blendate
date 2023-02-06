//
//  InfoCard.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI

struct InfoCardsView: View {
    let details: User
    
    var body: some View {
        if !noInfo() {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(InfoType.allCases){ type in
                        if type.show(details){
                            InfoCard(type, details)
                        }
                    }
                }.padding()
            }
        }
    }
    
    private func noInfo()->Bool{
        for group in InfoType.allCases {
            if group.show(details) {
                return false
            }
        }
        return true
    }
}


struct InfoCard: View {
    let userPreferences: User
    let type: InfoType
    let icon: String
    
    init(_ type: InfoType, _ userPreferences: User){
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
                    .fixedSize()
                    .fontType(.semibold, 18, .DarkBlue)
                Spacer()
//                Image(icon)
//                    .renderingMode(.template)
//                    .foregroundColor(.DarkBlue)
            }
            switch type {
            case .personal:
                InfoData("Relationship Status", userPreferences.info.relationship)
                InfoData("Job Title", userPreferences.workTitle)
                InfoData("Education", userPreferences.schoolTitle)
            case .children:
                if userPreferences.info.isParent {
                    InfoData("Parent", "Has Children")
                    InfoData("Children", "\(userPreferences.info.children)")
                    InfoData("Ages", "\(userPreferences.info.childrenRange.label(min: 0, max: 22))")
                }
               
                InfoData("Family Plans", userPreferences.info.familyPlans)
            case .background:
                InfoData("Religion", userPreferences.info.religion)
                InfoData("Political View", userPreferences.info.politics)
                InfoData("Ethnicity", userPreferences.info.ethnicity)
            case .lifestyle:
                InfoData("Mobility", userPreferences.info.mobility)
                InfoData("Vices", userPreferences.info.vices.first ?? "")
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
    let info: String

    init(_ title: String, _ info: String){
        self.title = title
        self.info = info
    }

    var body: some View {
        if !info.isBlank {
            VStack(alignment: .leading) {
                Text(title)
                    .fontType(.regular, 13, .gray)
                Text(info)
                    .fontType(.regular, 14, .DarkBlue)
            }.padding(.bottom, 2)
        }
    }
}

enum InfoType: String, CaseIterable, Identifiable {
    var id: String {self.rawValue}
    case personal = "Personal"
    case children = "Children"
    case background = "Background"
    case lifestyle = "Lifestyle"
    
    var cards: [Detail] {
        switch self {
        case .personal:
            return [.relationship, .work, .education]
        case .children:
            return [.isParent, .children, .childrenRange, .familyPlans]
        case .background:
            return [.religion, .politics, .ethnicity]
        case .lifestyle:
            return [.mobility,.vices]
        }
    }
    
    func show(_ details: User) -> Bool {
        switch self {
        case .personal:
            if details.info.relationship.isBlank && details.workTitle.isBlank && details.schoolTitle.isBlank {
                return false
            } else {return true}
        case .children:
            if !(details.info.isParent) && details.info.familyPlans.isBlank {
                return false
            } else {return true}
        case .background:
            if details.info.religion.isBlank && details.info.politics.isBlank && details.info.ethnicity.isBlank {
                return false
            } else {return true}
        case .lifestyle:
            if details.info.mobility.isBlank && details.info.vices.isEmpty {
                return false
            } else {return true}
        }
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardsView(details: dev.michael)
    }
}


