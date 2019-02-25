//
//  StringExtension.swift
//  AuthTest
//
//  Created by Maxim Prigozhenkov on 24/02/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

import Foundation

extension String {
    
    func satisfiesRegexp(_ regexp: String) -> Bool {
        return range(of: regexp, options: .regularExpression) != nil
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return self.satisfiesRegexp(emailRegEx)
//
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: testStr)
    }
    
}
