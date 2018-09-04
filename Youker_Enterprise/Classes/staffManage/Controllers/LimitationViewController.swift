//
//  LimitationViewController.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/3.
//  Copyright © 2018年 apple. All rights reserved.
//

//限额管理

import UIKit

class LimitationViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Lv = LimitView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenW, height: 220))
        self.navigationItem.title = "限额管理"

       view.addSubview(Lv)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


