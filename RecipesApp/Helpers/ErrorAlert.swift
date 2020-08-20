//
//  ErrorAlert.swift
//  RecipesApp
//
//  Created by acon on 20/08/2020.
//  Copyright © 2020 acon. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    static func createErrorAlert(errorMessage: String, completion: (()->Void)?) -> UIAlertController {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""),
                                      message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""),
                                      style: .default, handler: { (_) in
                                        completion?()
        }))
        return alert
    }
}
