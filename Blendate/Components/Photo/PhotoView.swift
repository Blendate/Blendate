//
//  PhotoView.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import SwiftUI
import CachedAsyncImage
import PhotosUI

struct PhotoView: View {
    @Binding var photo: Photo
    
    let editmode: Bool
    let isCell: Bool
    private let size: (width: CGFloat, height: CGFloat)
    @State var showPicker = false
    @State var isLoading = false
    @State var showfull = false
    
    
    init(_ photo: Binding<Photo>, isCell: Bool = false){
        self.editmode = true
        self._photo = photo
        self.isCell = isCell
        
        switch photo.placement.wrappedValue {
            case 0,1: self.size = (160, 210)
            default: self.size = (100, 132)
        }

    }
    
    init(_ photo: Photo, _ isCell: Bool = false ){
        self.editmode = false
        self._photo = .constant(photo)
        self.isCell = isCell

        switch photo.placement {
            case 2,5,6: self.size = (162, 213)
            default: self.size = (162, 171)
        }

    }
    
    
    var body: some View {
        CachedAsyncImage(urlRequest: photo.request, urlCache: .imageCache) { image in
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
        .sheet(isPresented: $showfull) {
            CachedAsyncImage(urlRequest: photo.request, urlCache: .imageCache) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
        }
    }
    
    
    @MainActor
    func setPhoto(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5)
        else { return
//            throw FirebaseError.generic("Could Not Upload Image to Server")
        }
        Task {
            do {
                let photo = try await PhotoService().uploadPhoto(at: photo.placement, data)
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
        } else if !isCell {
            showfull = true
        }
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
        @State private var showfull = false
        var request: URLRequest?
        let size: CGFloat
        var isCell: Bool = false

        var body: some View {
            if isCell {
                image
            } else {
                image
                    .onTapGesture(perform: tapped)
                    .sheet(isPresented: $showfull) {
                        CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
            }

        }
        
        private func tapped(){
            if !isCell {
                showfull = true
            }
        }
        
        var image: some View {
            CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
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
        @State var showfull = false

        var request: URLRequest?
        var body: some View {
            
            CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
                    .clipped()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
            }
            .onTapGesture{showfull = true}
            .sheet(isPresented: $showfull) {
                CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
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

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
