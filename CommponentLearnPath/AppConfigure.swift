//
//  AppConfigure.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/20.
//  Copyright © 2018年 TRS. All rights reserved.
//

import Foundation

/// 设计图的尺寸
let DeisgnSize = CGSize(width: 375, height: 667)


/// 屏幕size
let kScreenSize     = UIScreen.main.bounds.size
/// 屏幕宽
let kScreenWidth    = kScreenSize.width
/// 屏幕高
let kScreenHeight   = kScreenSize.height

/// 水平适配
///
/// - Parameter w: 宽度
/// - Returns: 适配宽度
func ScaleW(_ w: CGFloat) -> CGFloat {
    return (w / DeisgnSize.width) * kScreenWidth
}

/// 垂直适配
///
/// - Parameter h: 高度
/// - Returns: 适配高度
func ScaleH(_ h: CGFloat) -> CGFloat {
    return (h / DeisgnSize.height) * kScreenHeight
}

/// 尺寸适配 以宽度比例等比缩放宽高
///
/// - Parameter size: 尺寸
/// - Returns: 适配尺寸
func ScaleSize(_ size: CGSize) -> CGSize {
    return CGSize(width: ScaleW(size.width), height: ScaleW(size.height))
}


