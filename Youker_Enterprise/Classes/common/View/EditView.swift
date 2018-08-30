//
//  EditView.swift
//  youke
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class EditView: UIView,NibLoad {
    var callback:((NSInteger)->())?

    @IBOutlet weak var AllBTN: UIButton!
    
    @IBAction func DeleteDone(_ sender: Any) {
        
        if self.callback != nil  {
            callback!(1)
        }
    }
    
    @IBAction func allSelect(_ sender: Any) {
        callback!(0)
    }
}
