//
//  ZHVerifyCodeFieldCell.swift
//  ZHVerifyCodeField
//
//  Created by 张行 on 2017/8/23.
//  Copyright © 2017年 张行. All rights reserved.
//

import UIKit

@objc protocol BackwardTextFieldDelegate {
    @objc optional func textFieldDidDeleteBackward(_ textField: UITextField)
}

public class BackwardTextField: UITextField {
    
    weak var backwardDelegate: BackwardTextFieldDelegate?
    
    //监听删除事件
    override public func deleteBackward() {
        
        if backwardDelegate != nil {
            backwardDelegate?.textFieldDidDeleteBackward?(self)
        }
        
        super.deleteBackward()
    }
    
    //禁止复制粘贴
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

/// 每一个输入框的CELL
public class ZHVerifyCodeFieldCell: UICollectionViewCell {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.textFiled.frame = self.bounds
        self.contentView.addSubview(self.textFiled)
        self.textFiled.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    public lazy var textFiled:BackwardTextField = {
        let filed = BackwardTextField(frame: CGRect.zero)
        filed.layer.borderWidth = 1.0 / UIScreen.main.scale
        filed.layer.borderColor = #colorLiteral(red: 0.231372549, green: 0.6, blue: 0.9882352941, alpha: 1).cgColor
        filed.textAlignment = .center
        return filed
    }()
}
