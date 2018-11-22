//
//  LoginViewModel.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/22.
//  Copyright © 2018年 TRS. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class YHLoginViewModel {
    // 输出
    /// 用户名验证状态
    let userNameValidationStatus: Observable<ValidationResult>
    /// 密码验证状态
    let pwdValidationStatus: Observable<ValidationResult>
    /// 登录网络是否成功
    //    let login: Observable<Bool>
    
    init(inputs: (
        name: Observable<String>,
        pwd: Observable<String>
        //        loginTap: Observable<Void>)
        )) {
        
        userNameValidationStatus = inputs.name
            .filter({ $0.count == 11})
            .map({ (name) in
            return YHLoginValitionService.userNameValition(name)
        })
        .share(replay: 1)
        
//        userNameValidationStatus = inputs.name.flatMapLatest({ (name) in
//            return Observable.just(YHLoginValitionService.userNameValition(name))
//        })
//            .share(replay: 1)
        //        userNameValidationStatus = inputs.name.flatMapLatest{ (name) in
        //            return Observable.just(name.count == 11 ? ValidationResult.ok(message: "通过") : ValidationResult.failed(message: "请输入正确的手机号"))
        //            }
        //            .share(replay: 1)
        
        pwdValidationStatus = inputs.pwd.map{ (pwd) in
            return pwd.count >= 6 ? ValidationResult.ok(message: "通过") : ValidationResult.failed(message: "密码位数不能小于6")
            }
            .share(replay: 1)
        _ = Observable.combineLatest(inputs.name, inputs.pwd) {
            (name: $0, pwd: $1)
        }
        //        login = inputs.loginTap.withLatestFrom(nameAndpwd)
        //            .flatMapLatest({ (pair) in
        //                return Observable.just((pair.name.count + pair.pwd.count) % 2 == 0)
        //            })
        //            .share(replay: 1)
    }
}

class YHLoginValitionService {
    static func userNameValition(_ name: String) -> ValidationResult {
        print(name)
        if name.isEmpty {
            return .empty
        }
        if name.count != 11 {
            return .failed(message: "请输入正确的手机号")
        }
        return .ok(message: "通过")
    }
}
