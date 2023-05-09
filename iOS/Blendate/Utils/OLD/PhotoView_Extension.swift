//
//  PhotoView_Extension.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation
import SwiftUI

//extension PhotoView {
//    
//    struct Avatar: View {
//        @State private var showfull = false
//        let url: URL?
//        let size: CGFloat
//        var tapable: Bool = false
//        
//        var body: some View {
//            if !tapable {
//                image
//            } else {
//               image
//                .onTapGesture(perform: tapped)
//                .sheet(isPresented: $showfull) {
//                    AsyncImage(url: url) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                }
//            }
//        }
//        
//        private func tapped(){
//            if tapable {
//                showfull = true
//            }
//        }
//        
//        var image: some View {
//            AsyncImage(url: url) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: size, height: size)
//                    .clipShape(Circle())
//            } placeholder: {
//                Image("icon")
//                    .resizable()
//                    .renderingMode(.template)
//                    .foregroundColor(.white)
//                    .scaledToFit()
//                    .padding()
//                    .frame(width: size, height: size)
//                    .background(Color.Blue)
//                    .clipShape(Circle())
//            }
//        }
//        
//    }
//
//    struct Cover: View {
//        @State var showfull = false
//
//        let url: URL?
//        var request: URLRequest? {
//            guard let url = url else {return nil}
//            return URLRequest(url: url)
//        }
//        var body: some View {
//            
//            AsyncImage(url: url) { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
//                    .clipped()
////                    .cornerRadius(16, corners: [.topLeft, .topRight])
//            } placeholder: {
//                Rectangle().foregroundColor(.gray)
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
//            }
//            .onTapGesture{showfull = true}
//            .sheet(isPresented: $showfull) {
//                AsyncImage(url: url) { image in
//                    image
//                        .resizable()
//                        .scaledToFill()
//                } placeholder: {
//                    ProgressView()
//                }
//            }
//        }
//    }
//}
