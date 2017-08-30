//
//  ZHVerifyCodeFieldCell.swift
//  ZHVerifyCodeField
//
//  Created by 张行 on 2017/8/23.
//  Copyright © 2017年 张行. All rights reserved.
//

import UIKit

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
    
    public lazy var textFiled:UITextField = {
        let filed = UITextField(frame: CGRect.zero)
        filed.layer.borderWidth = 1.0 / UIScreen.main.scale
        filed.layer.borderColor = #colorLiteral(red: 0.231372549, green: 0.6, blue: 0.9882352941, alpha: 1).cgColor
        filed.textAlignment = .center
        return filed
    }()
}
