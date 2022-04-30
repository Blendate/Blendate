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
}
