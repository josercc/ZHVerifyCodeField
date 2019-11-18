//
//  ZHVerifyCodeFieldDelegate.swift
//  ZHVerifyCodeField
//
//  Created by 张行 on 2017/8/23.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation

@objc public protocol ZHVerifyCodeFieldDelegate {
    /// 配置ZHVerifyCodeFiledCell
    ///
    /// - Parameters:
    ///   - filed: 配置的ZHVerifyCodeFiled对象
    ///   - customCell: 自定义ZHVerifyCodeFiledCell的对象
    ///   - atIndex: 所在的索引
    @objc optional func field(_ field:ZHVerifyCodeField, customCell:ZHVerifyCodeFieldCell, atIndex index:Int)
    
    /// 配置未输入状态下的ZHVerifyCodeFiledCell
    ///
    /// - Parameters:
    ///   - filed: 配置的ZHVerifyCodeFiled对象
    ///   - customCell: 自定义ZHVerifyCodeFiledCell的对象
    @objc optional func field(_ field:ZHVerifyCodeField, customCellWhenEmpty cell:ZHVerifyCodeFieldCell)
    
    /// 配置正在输入状态下的ZHVerifyCodeFiledCell
    ///
    /// - Parameters:
    ///   - filed: 配置的ZHVerifyCodeFiled对象
    ///   - customCell: 自定义ZHVerifyCodeFiledCell的对象
    @objc optional func field(_ field:ZHVerifyCodeField, customCellWhenTyping cell:ZHVerifyCodeFieldCell)
    
    /// 配置已输入状态下的ZHVerifyCodeFiledCell
    ///
    /// - Parameters:
    ///   - filed: 配置的ZHVerifyCodeFiled对象
    ///   - customCell: 自定义ZHVerifyCodeFiledCell的对象
    @objc optional func field(_ field:ZHVerifyCodeField, customCellWhenTyped cell:ZHVerifyCodeFieldCell)
    
    /// 输入完验证码的回调
    ///
    /// - Parameters:
    ///   - field: ZHVerifyCodeFiled
    ///   - text: 完成输入的文本
    @objc optional func field(_ field:ZHVerifyCodeField, didCompletionInputCode text:String)
}
