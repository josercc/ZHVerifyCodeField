//
//  ZHVerifyCodeFiledDelegate.swift
//  ZHVerifyCodeFiled
//
//  Created by 张行 on 2017/8/23.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation

@objc public protocol ZHVerifyCodeFiledDelegate {
    /// 配置ZHVerifyCodeFiledCell
    ///
    /// - Parameters:
    ///   - filed: 配置的ZHVerifyCodeFiled对象
    ///   - customCell: 自定义ZHVerifyCodeFiledCell的对象
    ///   - atIndex: 所在的索引
   @objc optional func filed(_ filed:ZHVerifyCodeFiled, customCell:ZHVerifyCodeFiledCell, atIndex:Int)
}
