//
//  HomeFootView.swift
//  youke
//
//  Created by Duan Chao on 2018/5/15.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
enum methodOP{
    
    
    case address,startTime,endTime,price
}

class HomeFootView: UIView {
    
    @IBOutlet weak var addressBtn: UIButton!
    
    
    @IBOutlet weak var StartBtn: UIButton!
    @IBOutlet weak var endBTN: UIButton!
    
    @IBOutlet weak var priceTF: UITextField!
    var callBak:(()->())?
    var submit:((String)->())?
    var operationBlock:((methodOP,String,@escaping PassBak)->())?
    class func LoadView()->HomeFootView{
    let view:HomeFootView  = Bundle.main.loadNibNamed("HomeFootView", owner: nil, options: nil)!.first as! HomeFootView
        return view
    }
  
    @IBAction func addressClick(_ sender: Any) {
        self.operationBlock!(methodOP.address,"在的",{ str in
            self.addressBtn.setTitle(str, for: .normal)
            
            })
    }
    
    @IBAction func startTimeClick(_ sender: Any) {
        self.operationBlock!(methodOP.startTime,"xx",{str in
         // NotificationCenter.default.post(name: NSNotification.Name.init("UIKeyboardDidHideNotification"), object: nil)
            self.StartBtn.setTitle(str, for: .normal)
        })
    }
    @IBAction func endTimeClick(_ sender: Any) {
        self.operationBlock!(methodOP.endTime,"xx",{str in
            
            self.endBTN.setTitle(str, for: .normal)
        })
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        priceTF.delegate = self
        setStartTime()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
        
        
    }
    
    //设置footView的默认值。
    func setStartTime(){
       self.StartBtn.setTitle(Date.getCurrentTimeByMonth(), for: .normal)
       self.endBTN.setTitle(Date.getTomorrowTimeByMonth(), for: .normal)
    }
    
    @objc func textFieldDidChange(){
        
        print(priceTF.text ?? "00")
        submit!(priceTF.text!)
    }
    
}
extension HomeFootView:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

