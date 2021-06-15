//
//  FirebaseImageView.swift
//  Blendate
//
//  Created by Michael Wilkowski on 4/19/21.
//

import SwiftUI
import UIKit
import Combine
import FirebaseStorage


struct FirebaseImageView: View {
    @ObservedObject var imageLoader:DataLoader
    @State var image:UIImage = UIImage()
    
    init(imageURL: String) {
        imageLoader = DataLoader(urlString:imageURL)
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .aspectRatio(contentMode: .fill)
            .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
            }
            .border(Color.gray, width: 1)
    }
}

class DataLoader: ObservableObject {
    @Published var didChange = PassthroughSubject<Data, Never>()
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        getDataFromURL(urlString: urlString)
    }
    
    func getDataFromURL(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
