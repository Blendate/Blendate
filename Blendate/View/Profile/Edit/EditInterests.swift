//
//  EditInterests.swift
//  Blendate
//
//  Created by Michael on 6/17/21.
//

import SwiftUI
import RealmSwift

struct EditInterests: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    
    @State var interests = RealmSwift.List<String>()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            InterestsGridView(interests: $interests)
                .padding(.horizontal)
        }.padding(.horizontal)
        .onAppear {
            self.interests = state.user?.userPreferences?.interests ?? RealmSwift.List<String>()
        }
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.interests.removeAll()
                state.user?.userPreferences?.interests.append(objectsIn: interests)
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
    }
}

struct EditInterests_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.LightPink.edgesIgnoringSafeArea(.all)
            EditInterests()
        }
            
    }
}
