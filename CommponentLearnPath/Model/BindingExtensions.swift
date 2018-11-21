//
//  BindingExtensions.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/21.
//  Copyright © 2018年 TRS. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


extension ValidationResult: CustomStringConvertible {
    var description: String {
        switch self {
        case let .ok(msg):
            return msg
        case .empty:
            return ""
        case .validating:
            return "validating ..."
        case .failed(message: let msg):
            return msg
        }
    }
}

struct ValidationColors {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}

extension ValidationResult {
    var textColor: UIColor {
        switch self {
        case .ok(message: _):
            return ValidationColors.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColors.errorColor
        }
    }
}

extension Reactive where Base: UILabel {
    var validationResult: Binder<ValidationResult> {
        return Binder(base, binding: { (label, result) in
            label.textColor = result.textColor
            label.text = result.description
        })
    }
}

