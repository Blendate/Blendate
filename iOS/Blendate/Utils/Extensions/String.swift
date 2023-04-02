//
//  String.swift
//  Blendate
//
//  Created by Michael on 4/29/22.
//

import Foundation

extension String {

    func camelCaseToWords() -> String {
        return unicodeScalars.dropFirst().reduce(String(prefix(1))) {
            return CharacterSet.uppercaseLetters.contains($1)
                ? $0 + " " + String($1)
                : $0 + String($1)
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
extension Optional where Wrapped == String {
    var isBlank: Bool {
        guard let string = self else {return false}
        return string.isBlank
    }
}

extension Optional where Wrapped == [String] {
    var isEmpty: Bool {
        guard let string = self else {return false}
        return string.isEmpty
    }
}
extension [String] {
    func stringArrayValue() -> String {
        let array = self
        guard !array.isEmpty else {return "--"}
        if array.count >= 2 {
            let first = array.map({$0}).prefix(upTo: 2).joined(separator:", ")
            let moreAmount = array.count - 2

            let more = moreAmount < 1 ? "":" +\(moreAmount) more"

            return first + more
        } else {
            return array.first ?? "T"
        }
    }
}

extension String {
    static let LoremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
}

