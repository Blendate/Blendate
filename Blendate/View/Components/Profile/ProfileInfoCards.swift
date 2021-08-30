//
//  ProfileInfoCads.swift
//  Blendate
//
//  Created by Michael on 8/8/21.
//

import SwiftUI

struct ProfileInfoCards: View {
    
    @Binding var userPref: UserPreferences?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false, content: {
                VStack{
                    HStack(alignment:.top){
                        if showPersonal() { InfoCard(.personal, userPref) }
                        if showChildren() { InfoCard(.children, userPref) }
                        if showBackground() { InfoCard(.background, userPref) }
                        if showLifestyle() { InfoCard(.lifestyle, userPref) }
                    }.padding(.horizontal)
                    Spacer()
                }.padding(.vertical)
        })
    }
    
    
    func showPersonal()->Bool {
        if userPref?.relationship == nil && ((userPref?.workTitle.isEmpty) != nil) && ((userPref?.schoolTitle.isEmpty) != nil) {
            return false
        } else {return true}
    }
    
    func showChildren()->Bool {
        if !(userPref?.isParent ?? false) && userPref?.familyPlans == nil {
            return false
        } else {return true}
    }
    
    func showBackground()->Bool {
        if userPref?.religion == nil && userPref?.politics == nil && userPref?.ethnicity == nil {
            return false
        } else {return true}
    }
    
    func showLifestyle()->Bool {
        if userPref?.mobility == nil {
            return false
        } else {return true}
    }
    
}

struct ProfileInfoCards_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoCards(userPref: .constant(nil))
    }
}
