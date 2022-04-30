//
//  ImageView.swift
//  Blendate
//
//  Created by Michael on 6/16/21.
//

import SwiftUI

struct AvatarView: View {
    var url: URL?
    let size: CGFloat

    var body: some View {
        
        AsyncImage(url: url) { image in
            image
//                .renderingMode(.original)
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

struct CoverPhotoView: View {

    var url: URL?
    

    var body: some View {
        
        AsyncImage(url: url) { image in
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


struct PhotoVieww: View {
    @Binding var photo: Photo
    @State var showPhotoView = false
    
    let large: Bool
    let index: Int
    
    init(_ photo: Binding<Photo>){
        self.index = photo.wrappedValue.placement
        switch index {
        case 2,5,6:
            self.large = true
        default:
            self.large = false
        }
        self._photo = photo
    }
    
    
    var body: some View {
        Group {
            AsyncImage(url: photo.url) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 162, height: large ? 213:171, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } placeholder: {
                placeholder
            }
            .frame(width: 162, height: large ? 213:171, alignment: .center)
        }
    }
    
    var placeholder: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.Blue)
                .cornerRadius(15)
            Circle()
                .frame(width: 50)
                .foregroundColor(.LightGray)
            Image(systemName: "plus")
                .foregroundColor(.DarkBlue)
        }
        .frame(width: 162, height: large ? 213:171, alignment: .center)
    }
    
    struct FullPhotoView: View {
        let photo: Photo
        
        var body: some View {
            VStack {
                Spacer()
                AsyncImage(url: photo.url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
        //                     .frame(maxWidth: 300, maxHeight: 100)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                Spacer()
                HStack{
                    Spacer()
                }
            }
        }
    }
}
