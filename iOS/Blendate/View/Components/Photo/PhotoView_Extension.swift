//
//  PhotoView_Extension.swift
//  Blendate
//
//  Created by Michael on 11/22/22.
//

import Foundation
import SwiftUI
import CachedAsyncImage


extension PhotoView {
    
    struct MatchAvatar: View {
        @EnvironmentObject var session: SessionViewModel
        var match: Match
        @Binding var details: User?
        var size: CGFloat = 70
        
        var body: some View {
            PhotoView.Avatar(url: details?.avatar, size: size)
            .task {
                await fetchUser()
            }
        }
        
        @MainActor
        func fetchUser() async {
            guard details == nil, let withUID = match.withUserID(session.uid) else {return}
            self.details = try? await session.fetch(fid: withUID)

        }
    }
    
    struct Avatar: View {
        @State private var showfull = false
        let url: URL?
        let size: CGFloat
        var tapable: Bool = false
        
        var body: some View {
            if !tapable {
                image
            } else {
               image
                .onTapGesture(perform: tapped)
                .sheet(isPresented: $showfull) {
    //                image
                    AsyncImage(url: url) { image in
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
            if tapable {
                showfull = true
            }
        }
        
        var image: some View {
            AsyncImage(url: url) { image in
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

        let url: URL?
        var request: URLRequest? {
            guard let url = url else {return nil}
            return URLRequest(url: url)
        }
        var body: some View {
            
            CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2.2)
                    .clipped()
//                    .cornerRadius(16, corners: [.topLeft, .topRight])
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
//
//
//struct Avatar: View {
//    @State private var showfull = false
//    @State var url: URL?
//    let size: CGFloat
//    var isCell: Bool = false
//
//    var request: URLRequest? {
//        guard let url = url else {return nil}
//        return URLRequest(url: url)
//    }
//
//    var body: some View {
//        if isCell {
//            image
//        } else {
//            image
//                .onTapGesture(perform: tapped)
//                .sheet(isPresented: $showfull) {
//                    AsyncImage(url: url) { image in
//                        image
//                            .resizable()
//                            .scaledToFill()
//                    } placeholder: {
//                        ProgressView()
//                    }
//
////                        CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
////                            image
////                                .resizable()
////                                .scaledToFill()
////                        } placeholder: {
////                            ProgressView()
////                        }
//                }
//        }
//
//    }
//
//    private func tapped(){
//        if !isCell {
//            showfull = true
//        }
//    }
//
//    var image: some View {
//        CachedAsyncImage(urlRequest: request, urlCache: .imageCache) { image in
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: size, height: size)
//                .clipShape(Circle())
//        } placeholder: {
//            Image("icon")
//                .resizable()
//                .renderingMode(.template)
//                .foregroundColor(.white)
//                .scaledToFit()
//                .padding()
//                .frame(width: size, height: size)
//                .background(Color.Blue)
//                .clipShape(Circle())
//        }
//    }
//
//}
