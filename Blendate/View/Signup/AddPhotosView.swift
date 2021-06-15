//
//  AddPhotosView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI

struct AddPhotosView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
//    @EnvironmentObject var session: Session
    @EnvironmentObject var imageSession: ImagePickerModel
    
    let signup: Bool
    @State private var next = false
    @State var images: [Int:String] = [:]

    
    var active: Binding<Bool> { Binding (
        get: { (imageSession.profileImage != nil && imageSession.coverPhoto != nil && imageSession.photos.keys.count > 3)},
            set: { _ in }
        )
    }

    @Binding var user: User
    init(_ signup: Bool = false, _ user: Binding<User>){
        self._user = user
        self.signup = signup
    }
    
    var body: some View {
            VStack {
                HStack(alignment: .center) {
                    VStack {
                        Text("Profile Photo")
                            .blendFont(18, .DarkBlue)
                        EmptyPhoto(urlString: user.images[1] ?? "", imageNum: 1, selectedImage: $imageSession.profileImage)
                            .frame(width: 160, height: 210)
                    }
                    VStack {
                        Text("Cover Photo")
                            .blendFont(18, .DarkBlue)
                        EmptyPhoto(urlString: user.images[2] ?? "", imageNum: 2, selectedImage: $imageSession.coverPhoto)
                            .frame(width: 160, height: 210)
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
                        ForEach(3..<9) { i in
                            EmptyPhoto(urlString: user.images[i + 2] ?? "", imageNum: i + 2, selectedImage: $imageSession.photos[i+2])
                                .frame(width: 100, height: 132)
                        }
                    }
                }
                Spacer()
                Text("As part of our Community Guidelines; pictures of minors are prohibited, unless accompanied by an adult")
                    .blendFont(14, .white)
                Spacer()
            }.padding()
            .navigationBarItems(leading:
                                    BackButton(signup: signup, isTop: false) {
                                        mode.wrappedValue.dismiss()
                                    },
                                 trailing:
                                    NavigationLink(
                                        destination: MorePreferencesView($user),
                                        isActive: $next,
                                        label: {
                                            NextButton(next: $next, isTop: false)
                                        }
                                    ))
            .circleBackground(imageName: "", isTop: false)
    }
}

struct EmptyPhoto: View {
    @EnvironmentObject var session: Session

    var urlString: String
    var imageNum: Int
    
    @State var showPicker = false
    @Binding var selectedImage: UIImage?
    
    func save(){
//        API.User.saveImage(uid: session.user.uid, image: selectedImage, imageNum: imageNum) { (url) in
//            print(url)
//        } onError: { (errMsg) in
//            print(errMsg)
//        }
    }
    
    var body: some View {
        Group {
//            if urlString.count > 1 {
//                FirebaseImageView(imageURL: urlString)
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: imageNum < 3 ? 160:100, height: imageNum < 3 ? 210:132)
                    .cornerRadius(15)
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
                }.onTapGesture {
                    showPicker = true
                }
            }
        }
        .sheet(isPresented: $showPicker, onDismiss: save, content: {
            ImagePicker(selectedImage: $selectedImage)
        })
    }
}

#if DEBUG
struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddPhotosView(true, .constant(Dummy.user))
                .environmentObject(Session())
        }
    }
}
#endif
