//
//  Photo.swift
//  Blendate
//
//  Created by Michael on 8/4/21.
//

import Foundation
import RealmSwift

@objcMembers class Photo: EmbeddedObject, ObjectKeyIdentifiable {
    dynamic var _id = UUID().uuidString
    dynamic var thumbNail: Data?
    dynamic var picture: Data?
    dynamic var date = Date()
}

