//
//  Button.swift
//  Blendate
//
//  Created by Michael on 4/26/22.
//

import SwiftUI

extension Button where Label == Image {
    init(systemName: String, action: @escaping ()->Void){
        self.init(action: action) {
            Image(systemName: systemName)
        }
    }
}
