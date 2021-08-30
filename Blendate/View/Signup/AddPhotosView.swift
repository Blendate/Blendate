//
//  AddPhotosView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct AddPhotosView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @EnvironmentObject var state: AppState
    @Environment(\.realm) var userRealm
    @State var next = false
    let signup: Bool
    let isTop = false
    
    @State var profilePhoto: Photo?
    @State var coverPhoto: Photo?

    @State var photo1: Photo?
    @State var photo2: Photo?
    @State var photo3: Photo?
    @State var photo4: Photo?
    @State var photo5: Photo?
    @State var photo6: Photo?
    
    @State var images: [Int:String] = [:]

    init(_ signup: Bool = false){
        self.signup = signup
    }
    

    
    var body: some View {
            VStack {
                HStack(alignment: .center) {
                    VStack {
                        Text("Profile Photo")
                            .blendFont(18, .DarkBlue)
                        EmptyPhoto(imageNum: 1, photo: $profilePhoto)
                    }
                    VStack {
                        Text("Cover Photo")
                            .blendFont(18, .DarkBlue)
                        EmptyPhoto(imageNum: 2, photo: $coverPhoto)
                    }
                }.padding(.bottom, 50)
                .padding(.top, 30)
                HStack {
                    Spacer()
                    Text("Add up to 6 photos to your gallery")
                        .blendFont(14, .white)
                    Spacer()
                }.padding(.vertical)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        EmptyPhoto(imageNum: 3, photo: $photo1)
                        EmptyPhoto(imageNum: 4, photo: $photo2)
                        EmptyPhoto(imageNum: 5, photo: $photo3)
                        EmptyPhoto(imageNum: 6, photo: $photo4)
                        EmptyPhoto(imageNum: 7, photo: $photo5)
                        EmptyPhoto(imageNum: 8, photo: $photo6)
                    }
                }
                Spacer()
                Text("As part of our Community Guidelines; pictures of minors are prohibited, unless accompanied by an adult")
                    .blendFont(14, .white)
                Spacer()
                NavigationLink(
                    destination: MorePreferencesView(signup),
                    isActive: $next,
                    label: { EmptyView() }
                )
            }.padding()
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: false) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavNextButton(signup, isTop, save)
            )
            .circleBackground(imageName: nil, isTop: false)
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
        if signup { next = true} else { self.mode.wrappedValue.dismiss()}
    }
    
}


struct EmptyPhoto: View {
//    var urlString: String
    var imageNum: Int
    
    @State var showPicker = false
    @Binding var photo: Photo?
    
    var body: some View {
        Group {
            if let picture = photo?.picture,
                let image = UIImage(data: picture) {
                    Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageNum < 3 ? 160:100, height: imageNum < 3 ? 210:132)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    Circle()
                        .frame(width: 50)
                        .foregroundColor(.LightGray)
                    Image(systemName: "plus")
                        .foregroundColor(.DarkBlue)
                }
                .frame(width: imageNum < 3 ? 160:100, height: imageNum < 3 ? 210:132)
            }
        }
        .onTapGesture {
            addAttachment()
        }
    }
    
    private func addAttachment() {
        PhotoCaptureController.show(source: .photoLibrary) { controller, photo in
            self.photo = photo
            controller.hide()
        }
    }
}

#if DEBUG
struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddPhotosView(true)
                .environmentObject(AppState())
        }
    }
}
#endif

//struct EmptyPhoto2: View {
////    var urlString: String
//    var imageNum: Int
//
//    @State var showPicker = false
//    @Binding var selectedImage: UIImage?
//
//    var body: some View {
//        Group {
//            if let image = selectedImage {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: imageNum < 3 ? 160:100, height: imageNum < 3 ? 210:132)
//                    .clipShape(RoundedRectangle(cornerRadius: 15))
//            } else {
//                ZStack {
//                    Rectangle()
//                        .foregroundColor(.white)
//                        .cornerRadius(15)
//                    Circle()
//                        .frame(width: 50)
//                        .foregroundColor(.LightGray)
//                    Image(systemName: "plus")
//                        .foregroundColor(.DarkBlue)
//                }
//                .frame(width: imageNum < 3 ? 160:100, height: imageNum < 3 ? 210:132)
//            }
//        }
//        .onTapGesture {
//            showPicker = true
//        }
//        .sheet(isPresented: $showPicker) {
//            ImagePicker(selectedImage: $selectedImage)
//        }
//    }
//}
