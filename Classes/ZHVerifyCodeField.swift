//
//  ZHVerifyCodeField.swift
//  ZHVerifyCodeField
//
//  Created by 张行 on 2017/8/22.
//  Copyright © 2017年 张行. All rights reserved.
//

import UIKit


/// 验证验证码的试图
@IBDesignable
public class ZHVerifyCodeField: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UITextFieldDelegate, BackwardTextFieldDelegate {
    
    /// ZHVerifyCodeField常亮字符串
    private struct ZHVerifyCodeFieldStringName {
        /// ZHVerifyCodeFieldCell的标识符
        static var fieldCellIdentifier = "kZHVerifyCodeFieldCellIdentifier"
    }
        
    /// ZHVerifyCodeField设置的数据源
    @IBInspectable weak public var dataSource:ZHVerifyCodeFieldDataSource?
    
    @IBInspectable weak public var delegate:ZHVerifyCodeFieldDelegate?
    
    @IBInspectable public var item:Int = 4 {
        didSet {
            reloadView()
        }
    }
    
    private var edgeInsets:UIEdgeInsets = UIEdgeInsets.zero
    
    private var itemSpance:CGFloat = 0
    
    required public init(number:Int, frame:CGRect = CGRect.zero) {
        self.item = number
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    public convenience override init(frame: CGRect) {
        self.init(number: 4, frame: frame)
    }
    

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        reloadView()
    }
    
    private func setup() {
        self.collectionView.frame = self.bounds
        self.addSubview(self.collectionView)
    }
    
    public func reloadView() {
        guard self.bounds != CGRect.zero else {
            return
        }
        assert(self.item > 1)
        if let dataSource = self.dataSource {
            if let edgeInsets = dataSource.edgeInsets?(self) {
                self.edgeInsets = edgeInsets
            }
            
            if let itemSpance = dataSource.itemSpance?(self) {
                self.itemSpance = itemSpance
            }
        }
        
        if self.itemSpance == 0 {
            self.itemSpance = self.defaultItemSpance()
        }
        
        assert(self.itemSpance > 0)
        self.collectionView.reloadData()
    }
    
    public func clearAllCode() {
        for e in collectionView.visibleCells.enumerated() {
            guard let cell = e.element as? ZHVerifyCodeFieldCell else {
                continue
            }
            cell.textFiled.text = nil
            self.updateTextFieldStyle(withTyping: nil)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.item
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHVerifyCodeFieldStringName.fieldCellIdentifier, for: indexPath) as! ZHVerifyCodeFieldCell
        if let delegate = self.delegate {
            delegate.field?(self, customCell: cell, atIndex: indexPath.row)
            delegate.field?(self, customCellWhenEmpty: cell)
        }
        cell.textFiled.delegate = self;
        cell.textFiled.backwardDelegate = self
        cell.textFiled.keyboardType = .numberPad
        return cell
    }
    
    private lazy var collectionView:UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.register(ZHVerifyCodeFieldCell.self, forCellWithReuseIdentifier: ZHVerifyCodeFieldStringName.fieldCellIdentifier)
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return view
    }()
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width  = (collectionView.bounds.width - edgeInsets.left - edgeInsets.right - CGFloat(item - 1) * itemSpance) / CGFloat(item)
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpance
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateTextFieldStyle(withTyping: textField)
    }
    
    func textFieldDidDeleteBackward(_ textField: UITextField) {
        if let text = textField.text {
            if text.count > 0 {
                return
            }
        }
        //回到上一输入框
        previousTextFieldEditing(field: textField)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard var text = textField.text as NSString? else {
            return false
        }
        text = text.replacingCharacters(in: range, with: string) as NSString
        if text.length == 0 {
            return true
        }
        guard Int(text as String) != nil else {
            return false
        }
        textField.text = text.substring(from: text.length - 1) as String
        nextTextFieldEditing(field: textField)
        return false
    }
    
    private func defaultItemSpance() -> CGFloat {
        let width = self.bounds.width
        let height = self.bounds.height
        let itemWidth = height * CGFloat(item)
        let itemSpance:CGFloat = (width - itemWidth - edgeInsets.left - edgeInsets.right) / CGFloat((item - 1))
        return itemSpance
    }
    
    private func previousTextFieldEditing(field:UITextField) {
        let cells = collectionView.visibleCells
        var previousField: UITextField?
        var isFind: Bool = false
        for e in cells.reversed().enumerated() {
            guard let cell = e.element as? ZHVerifyCodeFieldCell else {
                continue
            }
            if isFind && previousField == nil {
                previousField = cell.textFiled
            }
            if cell.textFiled == field {
                isFind = true
            }
        }
        if let previous = previousField {
            previous.becomeFirstResponder()
            self.updateTextFieldStyle(withTyping: previous)
        }
    }
    
    private func nextTextFieldEditing(field:UITextField) {
        let cells = collectionView.visibleCells
        var nextField:UITextField?
        var isFind:Bool = false
        var text = ""
        for e in cells.enumerated() {
            guard let cell = e.element as? ZHVerifyCodeFieldCell else {
                continue
            }
            text += cell.textFiled.text ?? ""
            if isFind && nextField == nil {
                nextField = cell.textFiled
            }
            if cell.textFiled == field {
                isFind = true
            }
        }
        //已全部输入
        if text.count >= self.item {
            field.resignFirstResponder()
            delegate?.field?(self, didCompletionInputCode: text)
            return
        }
        
        if let next = nextField {
            next.becomeFirstResponder()
            self.updateTextFieldStyle(withTyping: next)
        }
    }
    
    private func updateTextFieldStyle(withTyping textField: UITextField?) {
        for e in collectionView.visibleCells.enumerated() {
            guard let cell = e.element as? ZHVerifyCodeFieldCell else {
                continue
            }
            if textField == cell.textFiled {
                delegate?.field?(self, customCellWhenTyping: cell)
                continue
            }
            let text = cell.textFiled.text
            if text == nil || text!.isEmpty {
                delegate?.field?(self, customCellWhenEmpty: cell)
            } else {
                delegate?.field?(self, customCellWhenTyped: cell)
            }
        }
    }
}
