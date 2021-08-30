//
//  ImageView.swift
//  Blendate
//
//  Created by Michael on 6/16/21.
//

import SwiftUI


struct PhotoView: View {
    @Binding var photo: Photo?
    @State var showPicker = false
    @State var showPhotoView = false

//    let image: UIImage?
    let large: Bool
    let edit: Bool
    
    init(photo: Binding<Photo?>, large: Bool, _ edit: Bool = false) {
        self._photo = photo
        self.large = large
        self.edit = edit
    }
    
    var body: some View {
        Group {
            if let picture = photo?.picture,
                let image = UIImage(data: picture) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 162, height: large ? 213:171, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                if edit {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(15)
                        Circle()
                            .frame(width: 50)
                            .foregroundColor(.LightGray)
                        Image(systemName: "plus")
                            .foregroundColor(.DarkBlue)
                    }
                    .frame(width: 162, height: large ? 213:171, alignment: .center)
                }

            }
        }.onTapGesture {
            if edit {
                addAttachment()
            } else {
                showPhotoView = true
            }
        }
        .sheet(isPresented: $showPhotoView) {
            FullPhotoView(photo: photo)
        }

    }
    
    private func addAttachment() {
        PhotoCaptureController.show(source: .photoLibrary) { controller, photo in
            self.photo = photo
            controller.hide()
        }
    }
}

struct FullPhotoView: View {
    let photo: Photo?
    
    var body: some View {
        ZStack {
            if let picture = photo?.picture,
                let image = UIImage(data: picture) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
            }
        }
    }
}
