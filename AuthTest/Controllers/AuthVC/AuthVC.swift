//
//  AuthVC.swift
//  AuthTest
//
//  Created by Maxim Prigozhenkov on 23/02/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AuthVC: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var makeAccountButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var passwordText = String()
    
    var elementsBlockHeight: CGFloat = 0
    
    let viewModel = AuthViewModel()
    let disposeBag = DisposeBag()
    
    var isShowAlertDialog = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Авторизация"
        
        forgotPasswordButton.layer.borderWidth = 0.5
        forgotPasswordButton.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        
        passwordTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        topConstraint.constant = getHeightCenterY()
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if isShowAlertDialog == false {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                
                let newScreenHeight = self.view.bounds.height - keyboardHeight
                let elementsBlockHeight = getElementsBlockHeight()
                
                let newY = (newScreenHeight / 2) - (elementsBlockHeight / 2)
                
                var newFrame = self.view.frame
                newFrame.origin.y -= newY
                self.view.frame = newFrame
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        var newFrame = self.view.frame
        newFrame.origin.y = 0
        self.view.frame = newFrame
    }
    
    func getHeightCenterY() -> CGFloat {
        let screenHeight = self.view.bounds.height
        
        let blockHeight = getElementsBlockHeight()
        
        return ((screenHeight - blockHeight) / 2) - (blockHeight / 2)
    }
    
    func getElementsBlockHeight() -> CGFloat {
        let emailLabelY = emailLabel.frame.origin.y
        let makeAccountButtonBottomY = makeAccountButton.frame.origin.y + makeAccountButton.bounds.height
        return (makeAccountButtonBottomY - emailLabelY)
    }
 
}


