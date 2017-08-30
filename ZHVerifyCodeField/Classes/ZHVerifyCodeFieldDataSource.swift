//
//  ZHVerifyCodeFiledDataSource.swift
//  ZHVerifyCodeFiled
//
//  Created by 张行 on 2017/8/22.
//  Copyright © 2017年 张行. All rights reserved.
//

import Foundation

@objc public protocol ZHVerifyCodeFieldDataSource {
    /// * 设置上下左右的边界
    ///
    /// - Parameter filed: 需要设置的ZHVerifyCodeFiled的对象
    /// - Returns: UIEdgeInsets
    @objc optional func edgeInsets(_ filed:ZHVerifyCodeField) -> UIEdgeInsets
    /// 设置每一个item的宽度 默认根据高度和宽度自动计算
    ///
    /// - Parameter filed: 需要设置的ZHVerifyCodeFiled的对象
    /// - Returns: 每个Item的间距
    @objc optional func itemSpance(_ filed:ZHVerifyCodeField) -> CGFloat
}


