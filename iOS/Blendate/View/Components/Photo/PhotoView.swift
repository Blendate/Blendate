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
    @StateObject var model: PhotoViewModel
    @Binding var photo: Photo
    @EnvironmentObject var session: SessionViewModel
    
    let editmode: Bool
    let isCell: Bool
    private let size: (width: CGFloat, height: CGFloat)
    @State var showPicker = false
    @State var showfull = false
    @State var pickedImage: UIImage?
    
    
    init(_ photo: Binding<Photo>, isCell: Bool = false){
        self.editmode = true
        self._photo = photo
        self.isCell = isCell
        
        switch photo.placement.wrappedValue {
            case 0,1: self.size = (160, 210)
            default: self.size = (100, 132)
        }
        self._model = StateObject(wrappedValue: PhotoViewModel(photo: photo.wrappedValue))
    }
    
    init(_ photo: Photo, _ isCell: Bool = false ){
        self.editmode = false
        self._photo = .constant(photo)
        self.isCell = isCell

        switch photo.placement {
            case 2,5,6: self.size = (162, 213)
            default: self.size = (162, 171)
        }
        self._model = StateObject(wrappedValue: PhotoViewModel(photo: photo))

    }
    
    var request: URLRequest? {
        guard let url = photo.url else {return nil}
        return URLRequest(url: url)
    }
    
    var body: some View {
        CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
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
                Task {
                    await model.set(image: image, uid: session.uid)
                }
            }
        }
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
    
    
    private func photoTapped(){
        if editmode && !model.isLoading {
            model.isLoading = true
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

            if model.isLoading {
                ProgressView()
            } else {
                Image(systemName: "plus")
                    .foregroundColor(.DarkBlue)
            }
            
        }
        .frame(width: size.width, height: size.height, alignment: .center)
    }
}




struct PhotoView2_Previews: PreviewProvider {
    @State static var photo = Photo(placement: 2, url: URL(string: "https://www.tailorbrands.com/wp-content/uploads/2020/07/mcdonald-logo.jpg")!)
    static var previews: some View {
        PhotoView($photo)
    }
}

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
