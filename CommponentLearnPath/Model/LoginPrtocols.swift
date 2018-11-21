//
//  LoginPrtocols.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/21.
//  Copyright © 2018年 TRS. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


/// 检验结果
///
/// - ok: 通过
/// - empty: 空
/// - validating: 验证中
/// - failed: 验证失败
enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

enum SignupState {
    case signedUp(SignedUp: Bool)
}

protocol YHLoginAPI {
    func usernameAvailable(_ username: String) -> Observable<Bool>
    func signup(_ username: String, password: String) -> Observable<Bool>
    func login(_ username: String, password: String) -> Observable<Bool>
}

protocol YHValidationService {
    func validateUsername(_ username: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok(message: _):
            return true
        default:
            return false
        }
    }
}
