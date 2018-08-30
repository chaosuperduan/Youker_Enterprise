//
//  PayView.swift
//  youke
//
//  Created by keelon on 2018/5/29.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
enum PayStyle {
    case AliPay,WeixinPay
}
class PayView: UIView,NibLoad {

    var selectButton:UIButton?
    var callBack:((PayStyle)->())?
    var ptype:PayStyle?
    @IBOutlet weak var firstButton: UIButton!
    
    
    @IBOutlet weak var secondButton: UIButton!
    
    @IBAction func firstClick(_ sender: UIButton) {
        if selectButton != nil {
            selectButton?.isSelected = false
        }
        self.selectButton = firstButton
        self.selectButton?.isSelected = !(self.selectButton?.isSelected)!
        self.ptype = PayStyle.WeixinPay
        if self.callBack != nil {
            callBack!(PayStyle.WeixinPay)
        }
    }
    
    @IBAction func SecondClick(_ sender: UIButton) {
        if selectButton != nil {
            selectButton?.isSelected = false
        }
        self.selectButton = secondButton
        self.selectButton?.isSelected = !(self.secondButton?.isSelected)!
        if self.callBack != nil  {
            callBack!(PayStyle.AliPay)
        }
        
        self.ptype = PayStyle.AliPay
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        
        self.superview?.alpha = 1.0
        self.removeFromSuperview()
        
    }
    @IBAction func submitClick(_ sender: Any) {
        if self.ptype != nil {
             self.callBack!(self.ptype!)
        }
    }
    func show(){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        }, completion: { (true) in
            
        })
    }
    func close(){
         self.removeFromSuperview()
        
    }
}
