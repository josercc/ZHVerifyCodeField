//
//  ViewController.swift
//  ZHVerifyCodeField
//
//  Created by josercc on 08/30/2017.
//  Copyright (c) 2017 josercc. All rights reserved.
//

import UIKit
import ZHVerifyCodeField

class ViewController: UIViewController, ZHVerifyCodeFieldDataSource, ZHVerifyCodeFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let field = ZHVerifyCodeField(number: 4, frame: CGRect(x: 50, y: 50, width: 200, height: 40))
        field.dataSource = self
        field.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

