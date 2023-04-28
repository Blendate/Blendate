//
//  PhotoView.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI
import FirebaseStorage

struct PhotoView<S:Shape, Placeholder: View>: View {
    let url: URL?
    var size: (CGFloat, CGFloat) = (75,75)
    let shape: S
    @ViewBuilder var placeholder: Placeholder

    var body: some View {
        WebImage(url: url).placeholder { placeholder }
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: size.0, height: size.1)
        .clipShape(shape)
        .contentShape(shape)
    }
}

struct EditPhotoView<S:Shape>: View {
    let uid: String
    let placement: Int
    let shape: S
    @Binding var isLoading: Bool
    
    @State private var showPicker = false
    @State private var photoItem: PhotosPickerItem?
//    @State var photoData: Data?
    @Binding var photo: Photo?
    
    var size: (CGFloat, CGFloat) = (100,100)
    
    var body: some View {
        PhotoView(url: photo?.url, size: size, shape: shape) {
            ZStack {
                Color.DarkBlue
                Image(systemName: "plus").font(.largeTitle)
                    .foregroundColor(.white)

            }
        }
        .onChange(of: photoItem) { newValue in
            uploadImage(newValue)
        }
        .onTapGesture { if !isLoading { self.showPicker = true } }
        .photosPicker(isPresented: $showPicker, selection: $photoItem)
    }
    
    func uploadImage(_ item: PhotosPickerItem?) {
        guard let item else {return}
        isLoading = true
        Task {
            do {
                guard let imageData = try await item.loadTransferable(type: Data.self) else {return}
                let storageRef = Storage.storage().reference().child("\(uid)").child(String(placement))
                let _ = try await storageRef.putDataAsync(imageData)
                let url = try await storageRef.downloadURL()
                print("Uploaded Photo \(placement) to \n \(storageRef.fullPath)")
                await MainActor.run {
                    self.photo = Photo(placement: placement, url: url)
                    self.isLoading = false
                }
            } catch {
                print(error.localizedDescription)
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}

extension PhotoView {
    init(_ photo: Photo) where S == RoundedRectangle, Placeholder == Color {
        switch photo.placement {
        case 2,5,6: self.size = (162, 213)
        default: self.size = (162, 171)
        }
        self.url = photo.url
        self.shape = RoundedRectangle(cornerRadius: 16)
        self.placeholder = Color.Blue
    }
    
    init(avatar: URL?, size: CGFloat = 70) where S == Circle, Placeholder == Color {
        self.url = avatar
        self.size = (size, size)
        self.shape = Circle()
        self.placeholder = Color.Blue
    }
    
    init(url: URL?, size: (CGFloat, CGFloat) = (75,75), shape: S) where Placeholder == Color {
        self.url = url
        self.size = size
        self.shape = shape
        self.placeholder = Color.Blue
    }
}

extension EditPhotoView {
    init(uid: String, placement: Int, photo: Binding<Photo?>, isLoading: Binding<Bool>) where S == RoundedRectangle {
        self.uid = uid
        self.placement = placement
        self._isLoading = isLoading

        switch placement {
        case 2,5,6: self.size = (162, 213)
        default: self.size = (162, 171)
        }
        self.shape = RoundedRectangle(cornerRadius: 16)
        self._photo = photo

    }
}

struct PhotoView_Previews: PreviewProvider {
    @State static var photo = Photo(placement: 2, url: URL(string: "https://www.tailorbrands.com/wp-content/uploads/2020/07/mcdonald-logo.jpg")!)
    static var previews: some View {
        PhotoView(url: alice.details.photos[0]!.url, shape: Circle())
        PhotoView(alice.details.photos[0]!)
        PhotoView(Photo(placement: 3, url: URL(string: "https://google.com")!))
    }
}
