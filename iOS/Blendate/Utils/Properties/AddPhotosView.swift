//
//  AddPhotosView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI


struct AddPhotosView: View {
    let uid: String
    @Binding var photos: [Int:Photo]
    @State var isLoading = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    EditPhotoView(uid: uid, placement: 0, photo: $photos[0], isLoading: $isLoading)
                    EditPhotoView(uid: uid, placement: 1, photo: $photos[1], isLoading: $isLoading)
                }.padding(.top)
                Spacer()
                HStack {
                    Spacer()
                    Text("Add up to 6 photos to your gallery")
                        .font(.semibold, Color.Blue)
                        .padding(.bottom)
                    Spacer()
                }
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(2..<8) { i in
                            EditPhotoView(uid: uid, placement: i, photo: $photos[i], isLoading: $isLoading)
                            .padding(.vertical)
                        }
                    }
                }
                .padding(.bottom, 30)
                Text("As part of our Community Guidelines; pictures of minors are prohibited, unless accompanied by an adult")
                    .font(.headline, .white)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
            }
            .padding(.horizontal)
            if isLoading {
                ProgressView()
                    .scaleEffect(2)
//                    .frame(width: 50, height: 50)
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .padding(32)
                    .background(Color.black.opacity(0.8).cornerRadius(16))
                ProgressView()
            }
        }
    }
}
#warning("Add Avatar Crop")
//import PhotoSelectAndCrop



#if DEBUG
struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
//        AddPhotosView(model: PhotoViewModel(uid: aliceUID), photos: .constant(alice.details.photos))
//        PreviewSignup(path: .photos)
//            .previewDisplayName("Signup")
        EditPhotoView(uid: aliceUID, placement: 0, photo: .constant(nil), isLoading: .constant(false))
    }
}
#endif

