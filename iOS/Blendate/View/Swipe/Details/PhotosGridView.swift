//
//  PhotosGridView.swift
//  Blendate
//
//  Created by Michael on 2/10/22.
//

import SwiftUI
import CachedAsyncImage

struct PhotosGridView: View {
    
    enum Groups: CaseIterable {
        case first, second, third
        
        var photos: [Int] {
            switch self {
            case .first:
                return [2,3]
            case .second:
                return [4,5]
            case .third:
                return [6,7]
            }
        }
    }

    var photos: [Photo]
    let editMode: Bool
//    let rows = [ GridItem(.flexible()), GridItem(.flexible())]

    let rows = [ GridItem(.fixed(210)),
                  GridItem(.fixed(170)) ]
    
    init(_ photos: [Photo], _ editMode: Bool = false){
        self.photos = photos
        self.editMode = editMode
    }
    #warning("fix this to a grid with 2 collumns alternating")
    @State var selected: Photo?
    
    var body: some View {
        if !photos.isEmpty {
            VStack{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack{
                        VStack{
                            if let photo = photo(2), let _ = photo.url {
                                PhotoView2(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                            if let photo = photo(3), let _ = photo.url {
                                PhotoView2(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                        }.padding(.vertical)
                        VStack{
                            if let photo = photo(4), let _ = photo.url {
                                PhotoView2(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                            if let photo = photo(5), let _ = photo.url {
                                PhotoView2(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                        }
                        VStack{
                            if let photo = photo(6), let _ = photo.url {
                                PhotoView2(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                            if let photo = photo(7), let _ = photo.url {
                                PhotoView2(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                        }
                    }
                })
            }.padding()
                .sheet(item: $selected) { photo in
                    PhotoTabView(photos: photos, selected: photo)
                }
        }
    }
    
    private func photo(_ index: Int)->Photo?{
        return photos.photo(at: index)
    }

}

struct PhotoTabView: View {
    let photos: [Photo]
    @State var selected: Photo

    var body: some View {
        TabView(selection: $selected) {
            ForEach(photos) { photo in
                VStack {
                    CachedAsyncImage(urlRequest: photo.request, urlCache: .imageCache) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    Text(photo.description ?? "")
                        .font(.title)
                    
                }
                .tag(photo)
            }
        }.tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct PhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosGridView(dev.michael.photos)
    }
}
