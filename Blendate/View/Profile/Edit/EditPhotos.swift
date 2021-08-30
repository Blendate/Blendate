//
//  EditPhotos.swift
//  Blendate
//
//  Created by Michael on 6/17/21.
//

import SwiftUI
import UIKit


struct EditPhotos: View {
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    
    @State var profilePhoto: Photo?
    @State var coverPhoto: Photo?

    @State var photo1: Photo?
    @State var photo2: Photo?
    @State var photo3: Photo?
    @State var photo4: Photo?
    @State var photo5: Photo?
    @State var photo6: Photo?
    
    
    var body: some View {
        VStack {
//            HStack {
//                Spacer()
//                Button(action: save, label: {
//                    Text("Save")
//                        .padding()
//                        .foregroundColor(.white)
//                        .background(Color.Blue)
//                        .clipShape(Capsule())
//                })
//                .padding(.trailing)
//            }
            HStack(alignment: .top) {
                VStack {
                    PhotoView(photo: $photo1, large: true, true)
                    PhotoView(photo: $photo2, large: false, true)
                    PhotoView(photo: $photo3, large: true, true)
                }
                VStack {
                    PhotoView(photo: $photo4, large: false, true)
                    PhotoView(photo: $photo5, large: true, true)
                    PhotoView(photo: $photo6, large: false, true)
                }
            }.onAppear{
                loadImages()
            }
        }
        .onChange(of: profilePhoto, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.profilePhoto = value
            }
        })
        .onChange(of: coverPhoto, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.coverPhoto = value
            }
        })
        .onChange(of: photo1, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.photo1 = value
            }
        })
        .onChange(of: photo2, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.photo2 = value
            }
        })
        .onChange(of: photo3, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.photo3 = value
            }
        })
        .onChange(of: photo4, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.photo4 = value
            }
        })
        .onChange(of: photo5, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.photo5 = value
            }
        })
        .onChange(of: photo6, perform: { value in
            try? userRealm.write{
                state.user?.userPreferences?.photo6 = value
            }
        })
    }
    
    func loadImages(){
        profilePhoto = state.user?.userPreferences?.profilePhoto
        coverPhoto = state.user?.userPreferences?.coverPhoto
        photo1 = state.user?.userPreferences?.photo1
        photo2 = state.user?.userPreferences?.photo2
        photo3 = state.user?.userPreferences?.photo3
        photo4 = state.user?.userPreferences?.photo4
        photo5 = state.user?.userPreferences?.photo5
        photo6 = state.user?.userPreferences?.photo6
    }
    
    func save(){
        do {
            try userRealm.write {
                state.user?.userPreferences?.profilePhoto = profilePhoto
                state.user?.userPreferences?.coverPhoto = coverPhoto
                state.user?.userPreferences?.photo1 = photo1
                state.user?.userPreferences?.photo2 = photo2
                state.user?.userPreferences?.photo3 = photo3
                state.user?.userPreferences?.photo4 = photo4
                state.user?.userPreferences?.photo5 = photo5
                state.user?.userPreferences?.photo6 = photo6
            }
        } catch {
            state.error = "Unable to open Realm write transaction"
        }
    }
    
    
}

struct EditPhotos_Previews: PreviewProvider {
    static var previews: some View {
        EditPhotos()
    }
}
