//
//  PhotosGridView.swift
//  Blendate
//
//  Created by Michael on 2/10/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotosGridView: View {

    var photos: [Int:Photo]
//    let rows = [ GridItem(.flexible()), GridItem(.flexible())]

    let rows = [ GridItem(.fixed(210)),
                  GridItem(.fixed(170)) ]
    
    #warning("fix this to a grid with 2 collumns alternating")
    @State var selected: Photo?
    
    var body: some View {
        if !photos.isEmpty {
            VStack{
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack{
                        VStack{
                            if let photo = photos[2] {
                                PhotoView(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                            if let photo = photos[3] {
                                PhotoView(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                        }.padding(.vertical)
                        VStack{
                            if let photo = photos[4] {
                                PhotoView(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                            if let photo = photos[5] {
                                PhotoView(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                        }
                        VStack{
                            if let photo = photos[6] {
                                PhotoView(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                            if let photo = photos[7] {
                                PhotoView(photo)
                                    .onTapGesture {
                                        selected = photo
                                    }
                            }
                        }
                    }
                })
            }.padding()
                .sheet(item: $selected) { photo in
                    PhotoTabView(photos: photos, selected: photo.placement)
                }
        }
    }

}

struct PhotoTabView: View {
    let photos: [Int:Photo]
    @State var selected: Int

    var body: some View {
        TabView(selection: $selected) {
            ForEach(photos.sorted{$0.value.placement < $1.value.placement}, id: \.key) { key, photo in
                VStack {
                    WebImage(url: photo.url, options: [.scaleDownLargeImages])
                        .placeholder { ProgressView() }
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Text(photo.description ?? "")
                        .font(.title)
                    
                }
                .tag(photo.placement)
            }
        }.tabViewStyle(.page(indexDisplayMode: .always))
    }
}

struct PhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosGridView(photos: alice.photos)
    }
}

//enum Groups: CaseIterable {
//    case first, second, third
//
//    var photos: [Int] {
//        switch self {
//        case .first:
//            return [2,3]
//        case .second:
//            return [4,5]
//        case .third:
//            return [6,7]
//        }
//    }
//}
