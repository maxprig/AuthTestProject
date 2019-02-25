//
//  AuthVC+UITextFieldDelegate.swift
//  AuthTest
//
//  Created by Maxim Prigozhenkov on 24/02/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

import UIKit

extension AuthVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == passwordTextField {
            
            var hashPassword = String()
            let newChar = string.first
            let offsetToUpdate = passwordText.index(passwordText.startIndex, offsetBy: range.location)
            
            if string == "" {
                passwordText.remove(at: offsetToUpdate)
                return true
            }
            else { passwordText.insert(newChar!, at: offsetToUpdate) }
            
            for _ in 0..<passwordText.count {  hashPassword += "*" }
            textField.text = hashPassword
            return false
        }
        return true
    }
    
}
