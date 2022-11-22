//
//  TabViewOverlay.swift
//  Blendate
//
//  Created by Michael on 11/18/22.
//

import SwiftUI

enum Tab: String, CaseIterable, Identifiable {
    var id: String {self.rawValue }
    case match, likes, messages, community, profile
    
    var image: Image {
        switch self {
            
        case .match:
            return Image("icon-2")
        case .likes:
            return Image(systemName: "star")
        case .messages:
            return Image("chat")
        case .community:
            return Image(systemName: "person.3")
        case .profile:
            return Image("profile")
        }
    }
}

struct TabViewOverlay: View {
    @Binding var selection: Tab
    
    init(selection: Binding<Tab>){
        UITabBar.appearance().isHidden = true
        self._selection = selection
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selection: $selection)
            }
        }
    }
}

struct TabButton: View {
    
    var tab: Tab
    @Binding var selection: Tab
    
    var body: some View {
        Button {
            withAnimation{ selection = tab }
        } label: {
            tab.image
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 35, height: 35)
                .foregroundColor(selection == tab ? Color.Blue : Color.gray.opacity(0.7))
                .frame(maxWidth: .infinity)
        }
    }
}

struct TabViewOverlay_Previews: PreviewProvider {
    static var previews: some View {
        TabTest()
    }
}

struct TabTest: View {
    @State var selection: Tab = .match

    var body: some View {
        TabView(selection: $selection) {
            ForEach(Tab.allCases) { tab in
                Text(tab.rawValue)
            }
        }.overlay(
            TabViewOverlay(selection: $selection), alignment: .bottom
        )
    }
}
