//
//  ProfileView.swift
//  Blendate
//
//  Created by Michael on 6/1/21.
//

import SwiftUI
import RealmSwift



struct ProfileView: View {
    @EnvironmentObject var state: AppState
    @ObservedRealmObject var user: User
    let profileType: ProfileType

    @State var lineupIndex: Int = 0
    @State var editType = EditType.none
//    @State var userPref: UserPreferences?
    
    @State var showSheet = false
    @State var sheetState = SheetState.none
//    {
//        willSet {
//            showSheet = newValue != .none
//        }
//    }
    
    init(_ profileType: ProfileType, _ user: User){
        self.profileType = profileType
        self.user = user
    }

    var body: some View {
        NavigationView {
            if profileType == .dateProfile && lineupIndex >= state.lineup.count {
                NoMatches()
            } else {
                ScrollView {
                    coverPhoto
                    if editType != .none {
                        editView
                    } else {
                        ProfileAbout(userPref: userPref())
                        ProfileInfoCards(userPref: userPref())
                        ProfilePhotos(userPref: userPref())
                        ProfileInterests(userPref: userPref())
                    }
                }
                .background(Color.LightPink)
                .edgesIgnoringSafeArea(.top)
                .navigationBarHidden(true)
            }
        }
//        .onAppear{
//
//            if profileType == .dateProfile {
//                self.userPref = self.state.lineup.first?.userPreferences
//            } else {
//                self.userPref = user.userPreferences
//            }
//
//        }
        .sheet(isPresented: $showSheet, onDismiss: sheetDismiss, content: {
            sheetContent()
        })
        .onChange(of: sheetState, perform: { value in
            showSheet = value != .none
        })
    }
    
    func userPref()->Binding<UserPreferences?> {
        if profileType == .dateProfile {
            return .constant(state.lineup[lineupIndex].userPreferences)
        } else {
            return $user.userPreferences
        }
    }
    
    func sheetDismiss(){
        sheetState = .none
    }
    
    var coverPhoto: some View {
        ZStack(alignment: .bottom) {
            VStack {
                ProfileCoverPhoto(userPref: userPref())
                Spacer()
            }
            VStack {
                Spacer()
                ProfileCardView(type: profileType, editType: $editType, sheetState: $sheetState, userPref: userPref(), pass: pass, blend: blend)
                    
                    .if((profileType == .myProfile)) { view in
                        view.environment(\.realmConfiguration, UserConfig())
                    }
            }
        }.frame(width: UIScreen.main.bounds.width, height: 350)

    }

    
    var editView: some View {
        Group {
            switch editType {
            case .About:
                EditProfile(userPref: userPref())
            case .Photos:
                EditPhotos()
            case .Interests:
                EditInterests()
            case .none:
                EmptyView()
            }
        }
    }
    
    func pass(){
        print("Index: \(lineupIndex) Lineup: \(state.lineup.count)")
        lineupIndex += 1

//        if lineupIndex <= (state.lineup.count - 1)  {
//            self.userPref = self.state.lineup[lineupIndex].userPreferences
//        }

    }
    
    func blend(){
        
    }
    
    @ViewBuilder
    private func sheetContent() -> some View {
        if sheetState == .account {
            AccountView()
                .environmentObject(state)
        } else if sheetState == .preferences {
            PreferencesView()
                .environmentObject(state)

        // else if ...
        } else {
            EmptyView()
        }
    }

    
}

struct NoMatches: View {
    var body: some View {
        Text("No More Matches")
            .font(.system(size: 42))
    }
}

struct ProfileView_Previews: PreviewProvider {
        
    static var previews: some View {
        ProfileView(.myProfile, Dummy.user)
            .environmentObject(AppState())
        
        ProfileView(.dateProfile, Dummy.user)
            .environmentObject(AppState([Dummy.matchUser]))
    }
}

