//
//  ProfileInterests.swift
//  Blendate
//
//  Created by Michael on 8/8/21.
//

import SwiftUI
import RealmSwift

struct ProfileInterests: View {
    
    @Binding var userPref: UserPreferences?
    let layout = [
        GridItem(.adaptive(minimum: getRect().width * 0.425), spacing: 10)
    ]
    
    var body: some View {
        LazyVGrid(columns: layout, spacing: 10){
            ForEach(userPref?.interests ?? RealmSwift.List<String>(), id:\.self){ interest in
                InterestBubbleView(title: interest)
            }
        }.padding()
    }
}

struct ProfileInterests_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInterests(userPref: .constant(nil))
    }
}
