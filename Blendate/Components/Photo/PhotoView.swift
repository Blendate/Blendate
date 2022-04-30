//
//  PhotoView.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import SwiftUI
import CachedAsyncImage
import PhotosPicker
import PhotosUI

struct PhotoView: View {
    @Binding var photo: Photo
    let editmode: Bool
    
//    private let large: Bool
    private let size: (width: CGFloat, height: CGFloat)

    @State var isLoading = false
    @State var showPicker = false
    
    init(_ photo: Binding<Photo>){
        self.editmode = true
        self._photo = photo
        
        switch photo.placement.wrappedValue {
            case 0,1: self.size = (160, 210)
            default: self.size = (100, 132)
        }
    }
    
    init(_ photo: Photo){
        self.editmode = false
        self._photo = .constant(photo)
        
        switch photo.placement {
            case 2,5,6: self.size = (162, 213)
            default: self.size = (162, 171)
        }
    }
    
    
    var body: some View {
        CachedAsyncImage(url: photo.url) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: size.width, height: size.height, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        } placeholder: {
            placeholder
        }
        .onTapGesture(perform: photoTapped)
        .frame(width: size.width, height: size.height, alignment: .center)
        .sheet(isPresented: $showPicker) {
            ImagePicker { image in
                setPhoto(image)
            }
        }
    }
    
    
    @MainActor
    private func setPhoto(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5)
        else { return
//            throw FirebaseError.generic("Could Not Upload Image to Server")
        }
        Task {
            do {
                let photo = try await PhotoService.uploadPhoto(at: photo.placement, data)
                self.photo = photo
                isLoading = false
            } catch {
                isLoading = false
                printD(error.localizedDescription)
            }
        }

    }
    
    private func photoTapped(){
        if editmode && !isLoading {
            isLoading = true
            showPicker = true
        }
    }
    
    private var config: PHPickerConfiguration {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        return configuration
    }
    
    var placeholder: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(15)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
            Circle()
                .frame(width: 50)
                .foregroundColor(.LightGray)
                .shadow(color: .gray, radius: 1, x: 0, y: 2)

            if isLoading {
                ProgressView()
            } else {
                Image(systemName: "plus")
                    .foregroundColor(.DarkBlue)
            }
            
        }
        .frame(width: size.width, height: size.height, alignment: .center)
    }
}


extension PhotoView {

    struct Avatar: View {
        var url: URL?
        let size: CGFloat
        var body: some View {
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } placeholder: {
                Image("icon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .scaledToFit()
                    .padding()
                    .frame(width: size, height: size)
                    .background(Color.Blue)
                    .clipShape(Circle())
            }
        }
    }

    struct Cover: View {
        var url: URL?
        var body: some View {
            
            CachedAsyncImage(url: url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
                    .clipped()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
            }
        }
    }
}

struct PhotoView2_Previews: PreviewProvider {
    @State static var photo = Photo(url: URL(string: "https://www.tailorbrands.com/wp-content/uploads/2020/07/mcdonald-logo.jpg"), placement: 2)
    static var previews: some View {
        PhotoView($photo)
    }
}
