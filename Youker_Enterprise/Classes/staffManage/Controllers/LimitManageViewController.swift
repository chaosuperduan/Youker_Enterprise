//
//  LimitManageViewController.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/4.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LimitManageViewController: UIViewController {
    var mode:UserGroupModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUi()

        
    }
    func setUpUi(){
      self.navigationItem.title = mode?.group_Name
        
        
    }

   

   

}
