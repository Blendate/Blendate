//
//  CommunityView.swift
//  Blendate
//
//  Created by Michael on 8/8/22.
//

import SwiftUI

struct CommunityView: View {
//    @State var group
    @State var title: String = ""
    @State var text: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("I need", text: $title)
                } header: {
                    Text("Post Titiel")
                }
                
                Section {
                    TextField("I need", text: $title)
                } header: {
                    Text("Post Titiel")
                }

            }
            .toolbar {
                ToolbarItem(placment: .navigationBarTrailing, title: "New") {
                    
                }
            }
            .navigationBarTitle("Community")
        }
        .tabItem{Image(systemName: "person.3")}
    }
    
    
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
