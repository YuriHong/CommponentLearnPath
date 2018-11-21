//
//  ViewController.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/20.
//  Copyright © 2018年 TRS. All rights reserved.
//

import UIKit
import Foundation
import web3swift
import CommonCrypto

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 0...5 {
            let r = String.randomString(16)
            print("密钥: \(r)")
            let en = NSString.des("Hello world", key: r, isEncrypt: true)
            print("密文:\(en ?? "")")
            let de = NSString.des(en ?? "", key: r, isEncrypt: false)
            print("原文:\(de ?? "")")
        }
    }
    
    
    

}

extension String {
    
    /** 指定起始位置和长度，截取字符串(swift4) */
    public func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
    
    /// 生成指定长度的随机字符串
    ///
    /// - Parameter length: 指定长度
    /// - Parameter letter: 指定的字符串
    /// - Returns: 随机字符串
    public static func randomString(_ length: UInt, letter: String? = nil) -> String {
        guard length > 0 else {
            return ""
        }
        var randomStr = ""
        if let str = letter {
            for _ in 0..<length {
                randomStr.append(str.subString(start: Int(arc4random_uniform(UInt32(str.count))), length: 1))
            }
        }else {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789~!@#$%^&*()_+-[].,<>;:'"
            for _ in 0..<length {
                randomStr.append(letters.subString(start: Int(arc4random_uniform(UInt32(letters.count))), length: 1))
            }
        }
        return randomStr
    }
}

