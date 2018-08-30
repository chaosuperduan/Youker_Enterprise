//
//  commentView.swift
//  youke
//
//  Created by keelon on 2018/7/10.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class commentView: UIView,NibLoad{

    @IBOutlet weak var BTN1: UIButton!
    @IBOutlet weak var BTN2: UIButton!
    @IBOutlet weak var BTN3: UIButton!
    @IBOutlet weak var BTN4: UIButton!
    @IBOutlet weak var BTN5: UIButton!
    var startCount:NSInteger = 0
    @IBOutlet weak var commentTextView: UITextView!
    
    var mode:OrderMode?{
        didSet{
            refreshUI()
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commentTextView.delegate = self
        self.commentTextView.returnKeyType = .done
    }
    func  refreshUI() {
//        self.commentTextView.text = mode?.hotelInfo?.hotel_Introduce!
    }
    var operationBlock:((_ index:NSInteger)->())?
    
    @IBAction func starClick(_ sender: UIButton) {
        
        let button = sender
        
        if (button.isSelected == false) {
           
            startCount = startCount + 1
        }else{
            
            startCount = startCount - 1
            
        }
        print(startCount)
        button.isSelected = !button.isSelected
    }
    
    @IBAction func comment(_ sender: Any) {
        
        if self.operationBlock != nil  {
            self.operationBlock!(0)
        }
        
        
        
        
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        if self.operationBlock != nil  {
            self.operationBlock!(0)
        }
        
        
        
    }
    
    
    
    
}


extension commentView:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
      
        
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.frame.origin.y = self.origin.y - 120
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.frame.origin.y = self.origin.y - 120
        return true
    }
    
    
    
}
