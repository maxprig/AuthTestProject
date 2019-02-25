//
//  AuthVC+Actions.swift
//  AuthTest
//
//  Created by Maxim Prigozhenkov on 24/02/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

import UIKit

extension AuthVC {
    
    @IBAction func loginButtonTap() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if viewModel.checkEmail(emailTextField.text ?? "") {
            viewModel.checkPassword(passwordText).subscribe(onNext: { [weak self] flag in
                if let self = self {
                    self.viewModel.getWeather().subscribe(onNext: { [weak self] text in
                        self?.showAlert(withTitle: "Погода", withMessage: text)
                    }).disposed(by: self.disposeBag)
                }
                }, onError: { [weak self] error in
                    if let error = error as? Err {
                        self?.showAlert(withTitle: "Ошибка", withMessage: error.message)
                    }
            }).disposed(by: disposeBag)
        } else {
            showAlert(withTitle: "Ошибка", withMessage: "Некорректный email.")
        }
        
    }
    
    @IBAction func forgotPasswordButtonTap(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let alert = UIAlertController(title: "Восстановление пароля", message: "Введите свой email.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Ваш email."
            textField.keyboardType = .emailAddress
        }
        alert.addAction(UIAlertAction(title: "Восстановить", style: .default, handler: { _ in
            self.isShowAlertDialog = false
            if let textField = alert.textFields?.first {
                if textField.text?.isValidEmail() ?? false {
                    self.showAlert(withTitle: "Успешно", withMessage: "Пароль восстановлен.")
                } else {
                    self.showAlert(withTitle: "Ошибка", withMessage: "Некорректный email.")
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            self.isShowAlertDialog = false
        }))
        isShowAlertDialog = true
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func makeAccountButtonTap(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        let alert = UIAlertController(title: "Создание аккаунта", message: "Введите свой email.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Ваш email."
            textField.keyboardType = .emailAddress
        }
        alert.addAction(UIAlertAction(title: "Создать", style: .default, handler: { _ in
            self.isShowAlertDialog = false
            if let textField = alert.textFields?.first {
                if textField.text?.isValidEmail() ?? false {
                    self.showAlert(withTitle: "Успешно", withMessage: "Аккаунт создан.")
                    self.emailTextField.text = textField.text
                } else {
                    self.showAlert(withTitle: "Ошибка", withMessage: "Некорректный email.")
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { _ in
            self.isShowAlertDialog = false
        }))
        isShowAlertDialog = true
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapGestureDidTap(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
}
