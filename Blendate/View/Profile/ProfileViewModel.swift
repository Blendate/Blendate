//
//  ProfileViewModel.swift
//  Blendate
//
//  Created by Michael on 5/20/21.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    
//    @Published var user: User
//    @Published var lineup: [User]
    
    let type: ProfileType

    init(_ user: Binding<User>, _ type: ProfileType = .myProfile){
        self.type = type
//        self._user = user
    }
    
    
}
