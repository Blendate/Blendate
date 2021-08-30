//
//  EditProfile.swift
//  Blendate
//
//  Created by Michael on 6/14/21.
//

import SwiftUI
import RealmSwift

struct EditProfile: View {
//    @EnvironmentObject var state: AppState
    @Binding var userPref: UserPreferences?
    
    @Environment(\.realm) var userRealm
    
    @State var cell: Pref = .name
    @State var present = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                general
                personal
                children
                background
                other
            }
        }.padding()
//        .sheet(isPresented: $present, content: {
//            getSheet(cell)
//        })
        .onChange(of: cell, perform: { value in
            present.toggle()
        })
    }
    
    var general: some View {
        VStack(alignment: .leading) {
            Text("General")
                .fontWeight(.semibold)
                .font(.title2)
                .padding(.top)
                .foregroundColor(.Blue)
//            Button(action: {cell = .name }){
                EditProfileCell(.name, userPref)
                AboutCell(value: userPref?.bio ?? "About")

//                EditProfileCell(title: "Name", value: userPref?.fullName() ?? "Full Name")
            
//            Button(action: {cell = .bio }){
//                AboutCell(value: userPref?.bio ?? "About")
//            }
        }
    }
    
    var personal: some View {
        VStack(alignment: .leading) {
            Text("Personal")
                .fontWeight(.semibold)
                .font(.title2)
                .padding(.top)
                .foregroundColor(.Blue)
            EditProfileCell(.name, userPref)
            EditProfileCell(.birthday, userPref)
            EditProfileCell(.height, userPref)
            EditProfileCell(.relationship, userPref)
            EditProfileCell(.work, userPref)
            EditProfileCell(.education, userPref)


//            Button(action: {cell = .birthday }){
//                EditProfileCell(title: "Age", value: userPref?.ageString())
//            }
//            Button(action: {cell = .height }){
//                EditProfileCell(title: "Height", value: "\(doubleToString(userPref?.height ?? 0.0))")
//            }
//            Button(action: {cell = .relationship }){
//                EditProfileCell(title: "Relationship Status", value: userPref?.relationship)
//            }
//            Button(action: {cell = .work }){
//                EditProfileCell(title: "Job Title", value: userPref?.workTitle)
//            }
//            Button(action: {cell = .education }){
//                EditProfileCell(title: "Education", value: userPref?.schoolTitle)
//            }
        }
    }
    var children: some View {
        VStack(alignment: .leading) {
            Text("Children")
                .fontWeight(.semibold)
                .font(.title2)
                .padding(.top)
                .foregroundColor(.Blue)
            EditProfileCell(.parent, userPref)

//            Button(action: {cell = .parent }){
//                EditProfileCell(title: "Parental Status", value: (userPref?.isParent ?? true) ? "Yes":"No")
//            }

            if userPref?.isParent ?? false {
                EditProfileCell(.numberKids, userPref)
                EditProfileCell(.kidsRange, userPref)
//
//                Button(action: {cell = .numberKids }){
//                    EditProfileCell(title: "# of Children", value: "\(userPref?.children ?? 0)")
//                }
//                Button(action: {cell = .kidsRange }){
//                    EditProfileCell(title: "Children's Age Range", value: "\(userPref?.childAgeMin ?? 0)-\(userPref?.childAgeMax ?? 0)")
//                }
                
            }
            EditProfileCell(.wantKids, userPref)

//            Button(action: {cell = .wantKids }){
//                EditProfileCell(title: "Family Plans", value: userPref?.familyPlans)
//            }
        }
    }
    var background: some View {
        VStack(alignment: .leading) {
            Text("Background")
                .fontWeight(.semibold)
                .font(.title2)
                .padding(.top)
                .foregroundColor(.Blue)
            EditProfileCell(.religion, userPref)
            EditProfileCell(.ethnicity, userPref)
            EditProfileCell(.politics, userPref)

//            Button(action: {cell = .religion }){
//                EditProfileCell(title: "Religion", value: userPref?.religion)
//            }
//            Button(action: {cell = .ethnicity }){
//                EditProfileCell(title: "Ethnicity", value: userPref?.ethnicity)
//            }
//            Button(action: {cell = .politics }){
//                EditProfileCell(title: "Political Views", value: userPref?.politics)
//            }

        }
    }
    var other: some View {
        VStack(alignment: .leading) {
            Text("Other")
                .fontWeight(.semibold)
                .font(.title2)
                .padding(.top)
                .foregroundColor(.Blue)
            EditProfileCell(.mobility, userPref)
            EditProfileCell(.vices, userPref)

//            Button(action: {cell = .mobility }){
//                EditProfileCell(title: "Mobility", value: userPref?.mobility)
//            }
//            Button(action: {cell = .vices }){
//                EditProfileCell(title: "Vices", value: userPref?.vices.first)
//            }
        }
    }
}


struct AboutCell: View {
    let value: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("About")
                        .foregroundColor(.gray)
                    if !value.isEmpty {
                        Text(value)
                            .fontWeight(.semibold)
                            .foregroundColor(.DarkBlue)
                            .padding(.top)
                    }
                }
                Spacer()
                if value.isEmpty {
                    Text("--")
                        .foregroundColor(.DarkBlue)
                }
                Image("eye")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.Blue)
            }
            Divider()
        }.padding(.bottom)
    }
}

struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile(userPref: .constant(nil))
    }
}
