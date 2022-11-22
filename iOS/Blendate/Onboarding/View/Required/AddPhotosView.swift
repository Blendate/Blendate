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
    
    private func photo(_ index: Int)->Binding<Photo>{
        return $photos.first(where: {$0.placement.wrappedValue == index})!
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if !signup {
                Spacer()
            }
            HStack {
                VStack {
                    Text("Profile Photo")
                        .fontType(.semibold, 16, .DarkBlue)
                    PhotoView(photo(0), isCell: true)
                }
                VStack {
                    Text("Cover Photo")
                        .fontType(.semibold, 16, .DarkBlue)
                    PhotoView(photo(1), isCell: true)
                }
            }
            .foregroundColor(.DarkBlue)
            .padding(.top)
            Spacer()
            HStack {
                Spacer()
                Text("Add up to 6 photos to your gallery")
                    .fontType(.regular, 16, signup ? .white:.clear)
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(2..<8) { i in
                        PhotoView(photo(i), isCell: true)
                            .padding(.vertical)
                    }
                }
            }
            .padding(.bottom, 30)
            Text("As part of our Community Guidelines; pictures of minors are prohibited, unless accompanied by an adult")
                .fontType(.regular, 12, signup ? .white:.DarkBlue)
                .multilineTextAlignment(.center)
                .padding(.bottom)
        }.padding(.horizontal)
        .background(signup ? .clear:.LightGray)
    }
}


#if DEBUG
struct AddPhotosView_Previews: PreviewProvider {
    static var previews: some View {
//        PreviewSignup(.photos)
        AddPhotosView(photos: .constant(dev.details.photos), signup: false)
    }
}
#endif

