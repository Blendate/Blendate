//
//  InitialView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import SwiftUI

struct InitialView: View {
    
    @EnvironmentObject var session: Session
    @State private var tabIndex: Int = 1
    
    var body: some View {
        TabView(selection: $tabIndex) {
            ProfileView($session.user, .dateProfile)
                .tabItem { Image("icon") }
                .tag(1)
            MessagesView($session.user)
                .tabItem { Image("chat") }
                .tag(2)
            Text("Tab Content 3")
                .tabItem { Image("heart") }
                .tag(3)
            ProfileView($session.user, .myProfile)
                .tabItem { Image("profile") }
                .tag(4)
        }.onAppear(perform: listen)
    }
    
    func listen(){
        print("Listened IN")
    }
}

struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        InitialView()
    }
}
