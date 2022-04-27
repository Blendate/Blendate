//
//  TabBottomView.swift
//  Blendate
//
//  Created by Michael on 3/29/22.
//

import SwiftUI

struct SessionTabsView: View {
    @Binding var selectedIndex: Int
    @Binding var user: User

    init(_ user: Binding<User>, _ index: Binding<Int>){
//        self._messageVM = StateObject(wrappedValue: MessagesViewModel())
//        self._matchVM = StateObject(wrappedValue: MatchViewModel())
        
        self._user = user
        self._selectedIndex = index
        clearTab()
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedIndex) {
                ForEach(TabType.allCases) { tab in
                    getTabView(tab)
                        .tag(tab.rawValue)
                }
            }
            VStack {
                Spacer()
                TabBar($selectedIndex)
            }.edgesIgnoringSafeArea(.bottom)
        }
    }
    
    @ViewBuilder
    func getTabView(_ tab: TabType) -> some View {
        switch tab {
        case .lineup:
            MatchProfileView(sessionUser: $user)
                .transition(.opacity)
        case .messages:
            MessagesView()
        case .today:
            TodayView()
        case .profile:
            ProfileView($user)
        }
    }
    
    private func clearTab(){
        let tabBar = UITabBar.appearance()
        tabBar.barTintColor = UIColor.clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
}


struct TabBar: View {
    init(_ index: Binding<Int>){ _selectedIndex = index }
    
    @Binding var selectedIndex: Int
        
    var body: some View {
        HStack {
            Spacer()
            ForEach(TabType.allCases) { tab in
                Button {
                    self.selectedIndex = tab.id
                } label: {
                    let isSelected = selectedIndex == tab.id
                    let data = tab.tabItem
                    Image(isSelected ? data.selectedImage : data.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 28, height: 28)
                        .padding(10)
                        .padding(.horizontal)
                        .tint(isSelected ? .DarkBlue:.DarkBlue)
                        .background(isSelected ? Color.Blue.opacity(0.25):Color.clear)
                        .clipShape(Capsule())
                        .padding(.top)
                }
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding(.bottom)
        .background(Color.white)
        .clipShape(Capsule())
        .shadow(radius: 5, x: 0, y: 4)
    }
}

struct TabBottomView_Previews: PreviewProvider {
    static var previews: some View {
        SessionTabsView(.constant(dev.michael), .constant(3))
    }
    
}

struct ClassicTabBar: View {
    @Binding var selectedIndex: Int
    @Binding var user: User
    
    @StateObject var messageVM: MessagesViewModel
    @StateObject var matchVM: MatchViewModel

    init(_ user: Binding<User>, _ index: Binding<Int>){
        self._messageVM = StateObject(wrappedValue: MessagesViewModel())
        self._matchVM = StateObject(wrappedValue: MatchViewModel())
        
        self._user = user
        self._selectedIndex = index
    }
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            MatchProfileView(sessionUser: $user)
                .transition(.opacity)
                .environmentObject(matchVM)
                .tabItem{
                    Image("icon-2")
                }
                .tag(0)
            MessagesView()
                .environmentObject(messageVM)
                .tabItem{
                    Image("chat")
                }
                .tag(1)

            TodayView()
                .tabItem{
                    Image("heart")
                }
                .tag(2)

            ProfileView($user)
                .tabItem{
                    Image("profile")
                }
                .tag(3)

        }
        .task {
//            await messageVM.getConvos()
            await matchVM.getLineup()
        }
    }
}

