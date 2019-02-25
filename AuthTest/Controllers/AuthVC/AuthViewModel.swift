//
//  AuthViewModel.swift
//  AuthTest
//
//  Created by Maxim Prigozhenkov on 23/02/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

import Foundation
import RxSwift

struct Err: Error {
    var message: String
}

class AuthViewModel {
    
    let disposeBag = DisposeBag()
    lazy var networkService = NetworkService()
    
    func checkEmail(_ email: String) -> Bool {
        return email.isValidEmail()
    }
    
    func checkPassword(_ password: String) -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            if password.satisfiesRegexp("[A-Z]|[А-Я]") == false {
                observer.onError(Err(message: "В пароле должна быть минимум одна заглавная буква."))
            } else if password.satisfiesRegexp("[a-z]|[а-я]") == false {
                observer.onError(Err(message: "В пароле должна быть минимум одна строчная буква."))
            } else if password.satisfiesRegexp("[0-9]") == false {
                observer.onError(Err(message: "В пароле должна быть минимум одна цифра."))
            } else if password.count < 6 {
                observer.onError(Err(message: "Длина пароля должна быть не менее 6 символов."))
            } else {
                observer.onNext(true)
            }
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func getWeather() -> Observable<String> {
        return networkService.getWeather().map({ temp -> String in
            return "В Петербурге сейчас \(temp) градусов."
        })
    }
    
}
