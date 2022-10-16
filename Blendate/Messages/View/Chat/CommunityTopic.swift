//
//  CommunityTopic.swift
//  Blendate
//
//  Created by Michael on 10/1/22.
//

import Foundation
import FirebaseFirestoreSwift

struct CommunityTopic: Codable, Identifiable {
    @DocumentID var id: String?
    let title: String
    let subtitle: String
    let cid: String
    let author: String
}
