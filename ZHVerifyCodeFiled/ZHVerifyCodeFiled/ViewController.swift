//
//  ViewController.swift
//  ZHVerifyCodeFiled
//
//  Created by 张行 on 2017/8/22.
//  Copyright © 2017年 张行. All rights reserved.
//

import UIKit
import ZHVerifyCodeFiledFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = true
        let view = ZHVerifyCodeFiled(number: 4, frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        view.center = self.view.center
        self.view.addSubview(view)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

