//
//  FirebaseError.swift
//  Blendate
//
//  Created by Michael on 9/29/22.
//

import Foundation

enum FirebaseError: LocalizedError{
    case decode
    case server
    case generic(String)
    
    
    var errorDescription: String? {
        switch self {
        case .decode:
            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
        case .server:
            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
        case .generic(let string):
            return NSLocalizedString(string, comment: "Firebase Error")
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .decode:
            return NSLocalizedString("There was an error getting your data from the server, please contact support", comment: "Decode Error")
        case .server:
            return NSLocalizedString("There was a problem with the connection to the Blendate Server, please try again", comment: "Server Error")
        case .generic(let string):
            return NSLocalizedString(string, comment: "Firebase Error")
        }
    }
}
