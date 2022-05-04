//
//  String.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import Foundation

extension String {

    func camelCaseToWords() -> String {
        return unicodeScalars.reduce("") {
            if CharacterSet.uppercaseLetters.contains($1) {
                if $0.count > 0 {
                    return ($0 + " " + String($1))
                }
            }
            let string = ($0 + String($1))
            
            return string.prefix(1).capitalized + dropFirst()
        }
    }
    
    var isBlank: Bool {
      return allSatisfy({ $0.isWhitespace }) || isEmpty || self == "--"
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

