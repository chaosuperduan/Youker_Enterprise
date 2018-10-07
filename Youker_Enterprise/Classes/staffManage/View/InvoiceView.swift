//
//  InvoiceView.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/10/7.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class InvoiceView: UIView,NibLoad {

    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var callBack:((Bool)->())?
    
    @IBAction func click(_ sender: Any) {
        
        
        if self.callBack != nil {
            
            self.callBack!(true)
        }
    }

}
