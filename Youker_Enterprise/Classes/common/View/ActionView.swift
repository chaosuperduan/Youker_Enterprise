//
//  ActionView.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/21.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ActionView: UIView,NibLoad {
    var callBack:((Bool)->())?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    var title:String?{
        
        didSet{
            
            titleLabel.text = title
        }
        
    }
    
    var subtitle:String?{
        
        didSet{
            
           subLabel.text = subtitle
        }
    }
    
    @IBAction func SureClick(_ sender: Any) {
        
        if self.callBack != nil{
            callBack!(true)
        }
    }
    
    
    @IBAction func cancelClick(_ sender: Any) {
        callBack!(false)
        
        
        
    }
    
}
