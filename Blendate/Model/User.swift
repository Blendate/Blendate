//
//  User.swift
//  Blendate
//
//  Created by Michael Wilkowski on 1/14/21.
//

import Foundation

class User: Identifiable {
    
    var id: String
    var firstName: String
    var lastName: String
//    var gender: Gender = .male
    
    init(firstname: String, lastname: String, id: String){
        self.firstName = firstname
        self.lastName = lastname
        self.id = id
    }
    
}

enum Gender: String {
    case male
    case female
}
