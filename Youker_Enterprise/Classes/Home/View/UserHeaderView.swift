//
//  UserHeaderView.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/8/31.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class UserHeaderView: UIView,NibLoad {
    var callback:(()->())?

    @IBOutlet weak var ImageIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
   
    @IBAction func Setting(_ sender: Any) {
        
        if self.callback != nil {
            callback!()
        }
    }
    
}
