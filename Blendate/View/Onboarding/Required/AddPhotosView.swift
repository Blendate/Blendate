//
//  AddPhotosView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 3/9/21.
//

import SwiftUI
import PhotosUI

struct AddPhotosView: View {
    @Binding var photos: [Photo]
    
    let signup: Bool
    
    private func photo(_ index: Int)->Photo{
        return photos.first(where: {$0.placement == index}) ?? Photo(placement: index)
    }
    
    var body: some View {
        VStack {
            if !signup {
                Spacer()
            }
            HStack {
                VStack {
                    Text("Profile Photo")
                        .fontType(.regular, 16, .DarkBlue)
                    EmptyPhoto(photo: photo(0)) { photo in
                        self.photos.tapItem(photo)
                    }
                }
                VStack {
                    Text("Cover Photo")
                        .fontType(.regular, 16, .DarkBlue)
                    EmptyPhoto(photo: photo(1)) { photo in
                        self.photos.tapItem(photo)
                    }
                }
            }.padding(.bottom, 80)
                .foregroundColor(.DarkBlue)
            Spacer()
            HStack {
                Spacer()
                Text("Add up to 6 photos to your gallery")
                    .fontType(.regular, 16, signup ? .white:.clear)
                Spacer()
            }.padding(.vertical)
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(2..<8) { i in
                        EmptyPhoto(photo: photo(i)) { photo in
                            self.photos.tapItem(photo)
//                            self.photos.append(photo)
                        }
                    }
                }
            }.padding(.bottom, 70)
            Spacer()
            Text("As part of our Community Guidelines; pictures of minors are prohibited, unless accompanied by an adult")
                .fontType(.regular, 12, signup ? .white:.DarkBlue)
                .multilineTextAlignment(.center)
                .padding(.bottom)
        }.padding(.horizontal)
            .background(signup ? .clear:.LightGray)
    }
}

extension Array where Element == Photo {
    mutating func tapItem(_ element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
            append(element)
        } else {
            append(element)
        }
    }
}

struct EmptyPhoto: View {
    @State var photo: Photo

    @State var showPicker = false
    @State var image: UIImage?
    
    var action: (_ photo: Photo) -> Void


    var body: some View {
        let index = photo.placement
        Group {
            if let image = image {
                    Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: index < 2 ? 160:100, height: index < 2 ? 210:132)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } else {
                AsyncImage(url: photo.url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: index < 2 ? 160:100, height: index < 2 ? 210:132)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    ZStack {
                        Rectangle()
                            .foregroundColor((photo.id == 0 || photo.id == 1) ? Color.Blue.opacity(0.8) : Color.white)
                            .cornerRadius(15)
                        Circle()
                            .frame(width: 50)
                            .foregroundColor(.LightGray)
                        Image(systemName: "plus")
                            .foregroundColor(.DarkBlue)
                    }
                    .frame(width: index < 2 ? 160:100, height: index < 2 ? 210:132)
                }
                .frame(width: index < 2 ? 160:100, height: index < 2 ? 210:132)

            }
        }
        .onTapGesture {
            showPicker = true
        }
        .sheet(isPresented: $showPicker, onDismiss: {
            Task {
                do {
                    let photo = try await returnImage()
                    self.photo = photo
                    action(photo)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }) {
            ImagePicker(selectedImage: $image)
        }

    }

    private func returnImage() async throws -> Photo {
        guard let image = image,
              let data = image.jpegData(compressionQuality: 0.5)
        else { throw FirebaseError.generic("Could Not Upload Image to Server") }
        
        return try await PhotoService.uploadPhoto(at: photo.placement, data)

    }
}



#if DEBUG
struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewSignup(.photos)
    }
}
#endif

