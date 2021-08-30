//
//  PhotoCaptureController.swift
//  Blendate
//
//  Created by Michael on 8/6/21.
//

import UIKit
import SwiftUI
import RealmSwift

class PhotoCaptureController: UIImagePickerController {
    
    @EnvironmentObject var state: AppState

    private var photoTaken: ((PhotoCaptureController, Photo) -> Void)?
    private var photo = Photo()
    private let imageSizeThumbnails: CGFloat = 102
    private let maximumImageSize = 1024 * 1024 // 1 MB

    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        .portrait
    }

    static func show(source: UIImagePickerController.SourceType,
                     photoToEdit: Photo = Photo(),
                     photoTaken: ((PhotoCaptureController, Photo) -> Void)? = nil) {
        
        let picker = PhotoCaptureController()
        picker.photo = photoToEdit
        picker.setup(source)
        picker.photoTaken = photoTaken
        picker.present()
    }
    
    func setup(_ requestedSource: UIImagePickerController.SourceType) {
        if PhotoCaptureController.isSourceTypeAvailable(.camera) && requestedSource == .camera {
            sourceType = .camera
        } else {
            print("No camera found - using photo library instead")
            sourceType = .photoLibrary
        }
        allowsEditing = true
        delegate = self
    }
    
    func present() {
        UIApplication.shared.windows.first?.rootViewController?.present(self, animated: true)
    }
    
    func hide() {
        photoTaken = nil
        dismiss(animated: true)
    }
    
    private func compressImageIfNeeded(image: UIImage) -> UIImage? {
        let resultImage = image
        
        if let data = resultImage.jpegData(compressionQuality: 1) {
            if data.count > maximumImageSize {
                
                let neededQuality = CGFloat(maximumImageSize) / CGFloat(data.count)
                if let resized = resultImage.jpegData(compressionQuality: neededQuality),
                   let resultImage = UIImage(data: resized) {
                    
                    return resultImage
                } else {
                    print("Fail to resize image")
                }
            }
        }
        return resultImage
    }
}

extension PhotoCaptureController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let editedImage = info[.editedImage] as? UIImage,
              let result = compressImageIfNeeded(image: editedImage) else {
            print("Could't get the camera/library image")
            return
        }
        
        photo.date = Date()
        photo.picture = result.jpegData(compressionQuality: 0.8)
        photo.thumbNail = result.thumbnail(size: imageSizeThumbnails)?.jpegData(compressionQuality: 0.8)
        photoTaken?(self, photo)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        hide()
    }
}

extension UIImage {
    func thumbnail(size: CGFloat) -> UIImage? {
        var thumbnail: UIImage?
        guard let imageData = self.pngData() else {
            return nil
        }
        let options = [
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: size] as CFDictionary
        
        imageData.withUnsafeBytes { ptr in
            if let bytes = ptr.baseAddress?.assumingMemoryBound(to: UInt8.self),
               let cfData = CFDataCreate(kCFAllocatorDefault, bytes, imageData.count),
               let source = CGImageSourceCreateWithData(cfData, nil),
               let imageReference = CGImageSourceCreateThumbnailAtIndex(source, 0, options) {
                thumbnail = UIImage(cgImage: imageReference)
            }
        }
        
        return thumbnail
    }
}

struct ThumbNailView: View {
    let photo: Photo?
    private let compressionQuality: CGFloat = 0.8
    
    var body: some View {
        VStack {
            if let photo = photo {
                if photo.thumbNail != nil || photo.picture != nil {
                    if let photo = photo.thumbNail {
                        Thumbnail(imageData: photo)
                    } else {
                        if let photo = photo.picture {
                            Thumbnail(imageData: photo)
                        } else {
                            Thumbnail(imageData: UIImage().jpegData(compressionQuality: compressionQuality)!)
                        }
                    }
                }
            }
        }
    }
}
struct Thumbnail: View {
    let imageData: Data
    
    var body: some View {
        Image(uiImage: (UIImage(data: imageData) ?? UIImage()))
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

struct PhotoFullSizeView: View {
    let photo: Photo

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            if let picture = photo.picture {
                if let image = UIImage(data: picture) {
                    Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            HStack() {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                Text("Back")
            }
        })
    }
}


