//
//  NetworkService.swift
//  AuthTest
//
//  Created by Maxim Prigozhenkov on 23/02/2019.
//  Copyright © 2019 Maxim Prigozhenkov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class NetworkService {
    
    func getWeather() -> Observable<Int> {
        let url = "https://fcc-weather-api.glitch.me/api/current?lat=59.955591&lon=30.343324"
        return Observable<Any>.create { observer -> Disposable in
            Alamofire.request(url, method: .get).responseJSON(completionHandler: { resp in
                switch resp.result {
                    
                case .success(let val):
                    observer.onNext(val)
                    observer.onCompleted()
                case .failure(let err):
                    observer.onError(err)
                }
            })
            return Disposables.create()
            }.map({ value -> Int in
                let responce: [String: Any] = value as! [String: Any]
                let main: [String: Any] = responce["main"] as! [String: Any]
                let result: Int =  main["temp"] as! Int
                return result
            })
    }
    
}
