//
//  ProfilePhotos.swift
//  Blendate
//
//  Created by Michael on 8/8/21.
//

import SwiftUI

struct ProfilePhotos: View {
    
    @Binding var userPref: UserPreferences?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true, content: {
            VStack{
                HStack{
                    VStack{
                        if let photo1 = userPref?.photo1 {
                            PhotoView(photo: .constant(photo1), large: true)
                        }
                        if let photo2 = userPref?.photo2 {
                            PhotoView(photo: .constant(photo2), large: false)
                        }
                    }
                    VStack{
                        if let photo3 = userPref?.photo3 {
                            PhotoView(photo: .constant(photo3), large: false)
                        }
                        if let photo4 = userPref?.photo4 {
                            PhotoView(photo: .constant(photo4), large: true)
                        }
                    }
                    VStack{
                        if let photo5 = userPref?.photo5 {
                            PhotoView(photo: .constant(photo5), large: true)
                        }
                        if let photo6 = userPref?.photo6 {
                            PhotoView(photo: .constant(photo6), large: false)
                        }
                    }
                }
            }
        })
        .padding()
    }
}

struct ProfilePhotos_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotos(userPref: .constant(nil))
    }
}
