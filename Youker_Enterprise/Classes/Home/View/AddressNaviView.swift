//
//  AddressNaviView.swift
//  youke
//
//  Created by Duan Chao on 2018/5/16.
//  Copyright © 2018年 M2Micro. All rights reserved.
//
import UIKit

class AddressNaviView: UIView,NibLoad {

    @IBOutlet weak var CityButton: UIButton!
    
    @IBOutlet weak var CancelBTN: UIButton!
    @IBOutlet weak var searchTF: UITextField!
    var callBack:((String)->())?
    var operation:((Bool)->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
   super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    @objc func textFieldDidChange(){
        
        print(searchTF.text ?? "00")
        
        
        callBack!(searchTF.text!)
    }
    
    @IBAction func CitySelect(_ sender: Any) {
        
        operation!(true)
        
    }
    
    @IBAction func Cancel(_ sender: Any) {
        if operation != nil {
            operation!(false)
        }
        
    }
    
}
extension AddressNaviView:UITextFieldDelegate{
    
    
    
}
