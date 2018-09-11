//
//  LimitActionView.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/11.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class LimitActionView: UIView {
    
    var callback:((NSInteger)->())?

    @IBOutlet weak var NameTF: UITextField!
    
    
    @IBAction func Cancel(_ sender: Any) {
        callback!(0)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        
        callback!(1)
        
    }
    
}
