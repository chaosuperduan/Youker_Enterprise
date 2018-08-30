//
//  rounderImageView.swift
//  youke
//
//  Created by Duan Chao on 2018/5/14.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
class rounderImageView: UIImageView {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 5
        layer.masksToBounds = true;
    layer.borderWidth=3.0
        
        layer.borderColor = MainColor.cgColor
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        layer.masksToBounds = true;
        layer.borderWidth=3.0
        
        layer.borderColor = MainColor.cgColor
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        //self.backgroundColor = UIColor.red
        layer.cornerRadius = 5
        layer.masksToBounds = true;
        layer.borderWidth=3.0
        
        self.layer.borderColor = UIColor.black.cgColor
    }
    
}
