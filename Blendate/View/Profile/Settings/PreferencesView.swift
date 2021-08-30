//
//  PreferencesView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/22/21.
//

import SwiftUI
import RealmSwift

struct PreferencesView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @State var cell: Pref = .name
    @State var present = false
    @ObservedResults(User.self) var users


    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.Blue!]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.Blue!]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.LightPink.edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        basic
                        preferred
                    }
                }
                .padding()
            }
            .sheet(isPresented: $present, content: {
                getSheet(cell)
            })
            .onChange(of: cell, perform: { value in
                present.toggle()
            })
            .navigationBarItems(leading:
                        BackButton(signup: true, isTop: false) {
                            mode.wrappedValue.dismiss()
                        }
            )
            .navigationBarTitle("Preferences", displayMode: .inline)
        }

    }
    
    
    
    var basic: some View {
        VStack {
            PreferenceCell(.gender, state.user?.userPreferences)
            PreferenceCell(.seeking, state.user?.userPreferences)
            PreferenceCell(.location, state.user?.userPreferences)
        }
    }
    
    var preferred: some View {
        VStack {
            PreferenceCell(.kidsRange, state.user?.userPreferences)
            PreferenceCell(.ethnicity, state.user?.userPreferences)
            PreferenceCell(.religion, state.user?.userPreferences)
            PreferenceCell(.height, state.user?.userPreferences)
            PreferenceCell(.wantKids, state.user?.userPreferences)
            PreferenceCell(.politics, state.user?.userPreferences)
            PreferenceCell(.vices, state.user?.userPreferences)
        }
    }
}

struct PreferenceCell2: View {
    let title: String
    let value: String?
    let toggle: Bool
    let isAccount: Bool
    let action: ()->Void
    
    
    init(title: String, value: String?, toggle: Bool = false, _ isAccount: Bool = false, action: @escaping()->Void){
        self.title = title
        self.value = value
        self.toggle = toggle
        self.action = action
        self.isAccount = isAccount
    }
    
    var body: some View {
        Button(action: action) {
            VStack {
                HStack {
                    Text(title)
                        .foregroundColor(title == "Logout" ? .red:.gray)
                    Spacer()
                    if let value = value {
                        if value.isEmpty {
                            Text("--")
                                .foregroundColor(.DarkBlue)
                        } else {
                            Text(value)
                                .fontWeight(.semibold)
                                .foregroundColor(.DarkBlue)
                        }
                        if title != "Email" {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.Blue)
                        }
                    } else {
                        if toggle {
                            Toggle("", isOn: .constant(false))
                                .toggleStyle(SwitchToggleStyle(tint: .Blue))
                        } else {
                            Text(isAccount ?  "":"--")
                                .foregroundColor(.DarkBlue)
                            Image(systemName: "chevron.right")
                                .foregroundColor(title == "Logout" ? .red:.Blue)
                        }
                    }
                }
                Divider()
            }.padding(.bottom)
        }
    }

}
    

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PreferencesView()
        }
    }
}
