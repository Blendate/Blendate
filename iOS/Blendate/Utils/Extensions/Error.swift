//
//  Error.swift
//  Blendate
//
//  Created by Michael on 4/25/22.
//

import Foundation
import UIKit

struct ErrorInfo: Error, LocalizedError {
    var errorDescription: String?
    var failureReason: String?
    var recoverySuggestion: String?
    var helpAnchor: String?
}

extension UINavigationController {

  open override func viewWillLayoutSubviews() {
    navigationBar.topItem?.backButtonDisplayMode = .minimal
  }
}
