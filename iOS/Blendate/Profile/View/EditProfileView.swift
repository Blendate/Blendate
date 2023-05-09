//
//  EditProfileView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 5/4/23.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var model: UserViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showProfile = false
    var body: some View {
        NavigationStack {
            List {
                personal
                family
                background
                premium
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Preview"){ self.showProfile = true }
                        .fontWeight(.semibold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                        .fontWeight(.semibold)
                }
            }
            .listStyle(.grouped)
            .sheet(isPresented: $showProfile){
                ViewProfileView(user: model.user)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("Details")
        }
    }
    
    @ViewBuilder
    var personal: some View {
        Section {
            DetailCell($model.user.gender)
            DetailCell($model.user.location)
            DetailCell("Photos", systemImage: "photo.stack", value: model.user.photos.count.description) {
                AddPhotosView(uid: model.uid, photos: $model.user.photos)
            }
            DetailCell($model.user.bio)
            DetailCell($model.user.workTitle)
            DetailCell($model.user.schoolTitle)
        } header: {
            Label("Personal", systemImage: "person.fill")
                .foregroundColor(.DarkBlue)
                .fontWeight(.semibold)

        }
    }

    @ViewBuilder
    var family: some View {
        Section {
            DetailCell($model.user.isParent)
            if model.user.isParent.rawValue {
                DetailCell($model.user.children)
                DetailCell($model.user.childrenRange)
            }
            DetailCell($model.user.familyPlans)
            DetailCell($model.user.mobility)

        } header: {
            Label("Family", systemImage: "figure.2.and.child.holdinghands")
                .foregroundColor(.DarkBlue)
                .fontWeight(.semibold)

        }
    }
    
    @ViewBuilder
    var background: some View {
        Section {
            DetailCell($model.user.relationship)
            DetailCell($model.user.religion)
            DetailCell($model.user.politics)
        } header: {
            Label("Background", systemImage: "house")
                .foregroundColor(.DarkBlue)
                .fontWeight(.semibold)

        }
    }

    @ViewBuilder
    var premium: some View {
        Section {
            DetailCell($model.user.height)
            
            DetailCell("Vices", systemImage: Vices.systemImage, value: nil) {
                
            }
            DetailCell("Interests", systemImage: Vices.systemImage, value: nil) {

            }
        } header: {
            Label("Premium", systemImage: "lock")
                .foregroundColor(.Purple)
                .fontWeight(.semibold)

        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(UserViewModel(uid: aliceUID, user: alice))
    }
}
