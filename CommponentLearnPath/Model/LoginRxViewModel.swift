//
//  LoginRxViewModel.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/21.
//  Copyright © 2018年 TRS. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    // 输出
    let validatedUsername: Observable<ValidationResult>
    let validatedPassword: Observable<ValidationResult>
    let validatedPasswordRepeated: Observable<ValidationResult>
    
    let signupEnabled: Observable<Bool>
    let signedIn: Observable<Bool>
//    let signingIn: Observable<Bool>
    
    init(inputs: (
            username: Observable<String>,
            password: Observable<String>,
            repeatedPassword: Observable<String>,
            loginTaps: Observable<Void>),
         dependency: (
            API: LoginDefaultAPI,
            validationService: LoginDefaultValidationService))
    {
        let api = dependency.API
        let validationService = dependency.validationService
        
        validatedUsername = inputs.username
            .flatMapLatest({ (username) -> Observable<ValidationResult> in
                return validationService.validateUsername(username)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(ValidationResult.failed(message: "Error contacting server"))
            })
            .share(replay: 1)
        
        validatedPassword = inputs.password
            .map({ (password) in
                return validationService.validatePassword(password)
            })
            .share(replay: 1)
        
        validatedPasswordRepeated = Observable.combineLatest(inputs.password, inputs.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
            .share(replay: 1)
        
        let usernameAndPassword = Observable.combineLatest(inputs.username, inputs.password) { (username: $0, password: $1) }
        
        signedIn = inputs.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest({ (pair) in
                return api.signup(pair.username, password: pair.password)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(false)
            })
            .flatMapLatest({ (loggedIn) in
                return Observable.just(false)
            })
            .share(replay: 1)
        
        signupEnabled = Observable.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated,
            signedIn.asObservable())
            { (username, password, repeatPassword, signingIn) in
            return username.isValid &&
                password.isValid &&
                repeatPassword.isValid &&
                !signingIn
        }
        .distinctUntilChanged()
        .share(replay: 1)
    }
}



