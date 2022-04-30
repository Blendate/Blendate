//
//  PhotosGridView.swift
//  Blendate
//
//  Created by Michael on 2/10/22.
//

import SwiftUI

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
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false, content: {
                HStack{
                    VStack{
                        if let photo = photo(2) {
                            PhotoView(photo)
                        }
                        if let photo = photo(3) {
                            PhotoView(photo)
                        }
                    }
                    VStack{
                        if let photo = photo(4) {
                            PhotoView(photo)
                        }
                        if let photo = photo(5) {
                            PhotoView(photo)
                        }
                    }
                    VStack{
                        if let photo = photo(6) {
                            PhotoView(photo)
                        }
                        if let photo = photo(7) {
                            PhotoView(photo)
                        }
                    }
                }
            })
            .padding()
        }
    }
    
    private func photo(_ index: Int)->Photo?{
        return PhotoService.photo(photos, index)
    }

}

struct PhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosGridView(dev.michael.details.photos)
    }
}