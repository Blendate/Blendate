//
//  InfoCard.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI


struct InfoCard: View {
    let userPreferences: UserDetails
    let type: InfoType
    let icon: String
    
    init(_ type: InfoType, _ userPreferences: UserDetails){
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
                    .fontType(.regular, 15, .DarkBlue)
                Image(icon)
                    .renderingMode(.template)
                    .foregroundColor(.DarkBlue)
            }
            switch type {
            case .personal:
                InfoData("Relationship Status", userPreferences.relationship)
                InfoData("Job Title", userPreferences.workTitle)
                InfoData("Education", userPreferences.schoolTitle)
            case .children:
                if userPreferences.isParent {
                    InfoData("Parent", "Has Children")
                    InfoData("Children", "\(userPreferences.children)")
                    InfoData("Ages", "\(userPreferences.rangeString())")
                }
               
                InfoData("Family Plans", userPreferences.familyPlans)
            case .background:
                InfoData("Religion", userPreferences.religion)
                InfoData("Political View", userPreferences.politics)
                InfoData("Ethnicity", userPreferences.ethnicity)
            case .lifestyle:
                InfoData("Mobility", userPreferences.mobility)
                InfoData("Vices", userPreferences.vices.first ?? "")
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
        if !info.isEmpty {
            VStack(alignment: .leading) {
                Text(info)
                    .fontType(.regular, 14, .DarkBlue)
                Text(title)
                    .fontType(.regular, 13, .gray)
            }
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
            return [.parent, .numberKids, .kidsRange, .wantKids]
        case .background:
            return [.religion, .politics, .ethnicity]
        case .lifestyle:
            return [.mobility,.vices]
        }
    }
    
    func show(_ details: UserDetails) -> Bool {
        switch self {
        case .personal:
            if details.relationship.isEmpty && details.workTitle.isEmpty && details.schoolTitle.isEmpty {
                return false
            } else {return true}
        case .children:
            if !(details.isParent) && details.familyPlans.isEmpty {
                return false
            } else {return true}
        case .background:
            if details.religion.isEmpty && details.politics.isEmpty && details.ethnicity.isEmpty {
                return false
            } else {return true}
        case .lifestyle:
            if details.mobility.isEmpty && details.vices.isEmpty {
                return false
            } else {return true}
        }
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(InfoType.allCases) {type in
            InfoCard(type, dev.tyler.details)
                .previewLayout(.sizeThatFits)
        }
        
    }
}


