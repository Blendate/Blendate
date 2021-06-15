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
    let user: User
    let type: InfoType
    let icon: String
    
    init(_ type: InfoType, _ user: User){
        self.type = type
        self.user = user
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
                InfoData("Relationship Status", user.relationship?.rawValue)
                InfoData("Job Title", user.workTitle)
                InfoData("Education", user.schoolTitle)
            case .children:
                if user.isParent {
                    InfoData("Parental Status", "Has Children")
                }
                InfoData("# of Children", "\(user.children)")
                InfoData("Children's Age Range", "\(user.childrenAge.min) - \(user.childrenAge.max)")
                InfoData("Wants more Children", user.familyPlans?.rawValue)
            case .background:
                InfoData("Religion", user.religion?.rawValue)
                InfoData("Political View", user.politics?.rawValue)
                InfoData("Ethnicity", user.ethnicity?.rawValue)
            case .lifestyle:
                InfoData("Mobility", "Open to all")
                InfoData("Mobility", "Open to all")
                InfoData("Mobility", "Open to all")
            }
                

        }
        .frame(width: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .shadow(color: .gray, radius: 1, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 4))
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

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
            HStack {
                InfoCard(.personal, Dummy.user)
                InfoCard(.children, Dummy.user)
                InfoCard(.background, Dummy.user)
                InfoCard(.lifestyle, Dummy.user)
            }.padding()
        })
    }
}
