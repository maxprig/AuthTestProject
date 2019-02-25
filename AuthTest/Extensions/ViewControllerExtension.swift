//
//  ViewControllerExtension.swift
//  AuthTest
//
//  Created by Maxim Prigozhenkov on 24/02/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String = "", withMessage message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
