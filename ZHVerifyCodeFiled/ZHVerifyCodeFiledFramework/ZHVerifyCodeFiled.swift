//
//  ZHVerifyCodeFiled.swift
//  ZHVerifyCodeFiled
//
//  Created by 张行 on 2017/8/22.
//  Copyright © 2017年 张行. All rights reserved.
//

import UIKit


/// 验证验证码的试图
public class ZHVerifyCodeFiled: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    /// ZHVerifyCodeFiled常亮字符串
    private struct ZHVerifyCodeFiledStringName {
        /// ZHVerifyCodeFiledCell的标识符
        static var filedCellIdentifier = "kZHVerifyCodeFiledCellIdentifier"
    }
    
    /// ZHVerifyCodeFiled设置的数据源
    public var dataSource:ZHVerifyCodeFiledDataSource?
    
    public var delegate:ZHVerifyCodeFiledDelegate?
    
    public var item:Int = 4 {
        didSet {
            reloadView()
        }
    }
    
    private var edgeInsets:UIEdgeInsets = UIEdgeInsets.zero
    
    private var itemSpance:CGFloat = 0
    
    public required init(number:Int, frame:CGRect = CGRect.zero) {
        self.item = number
        super.init(frame: frame)
        self.collectionView.frame = frame
        self.addSubview(self.collectionView)
    }
    
    public override convenience init(frame: CGRect) {
        self.init(number: 4, frame: frame)
    }
    
    public convenience required init?(coder aDecoder: NSCoder) {
        self.init(number: 4)
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        reloadView()
    }
    
    
    public func reloadView() {
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
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.item
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHVerifyCodeFiledStringName.filedCellIdentifier, for: indexPath) as! ZHVerifyCodeFiledCell
        if let delegate = self.delegate {
            delegate.filed?(self, customCell: cell, atIndex: indexPath.row)
        }
        return cell
    }
    
    private lazy var collectionView:UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.register(ZHVerifyCodeFiledCell.self, forCellWithReuseIdentifier: ZHVerifyCodeFiledStringName.filedCellIdentifier)
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
    
    private func defaultItemSpance() -> CGFloat {
        let width = self.bounds.width
        let height = self.bounds.height
        let itemWidth = height * CGFloat(item)
        let itemSpance:CGFloat = (width - itemWidth - edgeInsets.left - edgeInsets.right) / CGFloat((item - 1))
        return itemSpance
    }
    
}
