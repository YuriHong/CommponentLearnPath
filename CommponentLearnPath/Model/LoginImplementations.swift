//
//  LoginImplementations.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/21.
//  Copyright © 2018年 TRS. All rights reserved.
//

import Foundation
import RxSwift

class LoginDefaultValidationService: YHValidationService {
    
    let API: LoginDefaultAPI
    
    static let shareLoginValidationService = LoginDefaultValidationService(API: LoginDefaultAPI())
    
    init(API: LoginDefaultAPI) {
        self.API = API
    }
    
    let minPasswordCount = 6
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        if username.isEmpty {
            return Observable.just(ValidationResult.empty)
        }
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return Observable.just(ValidationResult.failed(message: "Username can only contain numbers or digits"))
        }
        let loadingValue = ValidationResult.validating
        
        return API.usernameAvailable(username)
            .map({ (available) -> ValidationResult in
                if available {
                    return ValidationResult.ok(message: "Username available")
                }else {
                    return ValidationResult.failed(message: "Username already taken")
                }
            })
            .startWith(loadingValue)
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return ValidationResult.empty
        }
        if numberOfCharacters < minPasswordCount {
            return ValidationResult.failed(message: "Password must be at least \(minPasswordCount) characters")
        }
        return ValidationResult.ok(message: "Password acceptable")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return ValidationResult.empty
        }
        if repeatedPassword == password {
            return ValidationResult.ok(message: "Password repeated")
        }else {
            return ValidationResult.failed(message: "Password different")
        }
    }
}

class LoginDefaultAPI: YHLoginAPI {
    
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        let validateResult = arc4random() % 5 == 0 ? false : true
        // 模拟异步返回验证结果
        return Observable<Bool>.just(validateResult)
            .delay(1, scheduler: MainScheduler.instance)
    }
    
    func signup(_ username: String, password: String) -> Observable<Bool> {
        let result = arc4random() % 2 == 0 ? false : true
        return Observable.just(result)
            .delay(1, scheduler: MainScheduler.instance)
    }
    
    func login(_ username: String, password: String) -> Observable<Bool> {
        let validateResult = arc4random() % 5 == 0 ? false : true
        // 模拟异步返回验证结果
        return Observable<Bool>.just(validateResult)
            .delay(1, scheduler: MainScheduler.instance)
    }
    
    
}

