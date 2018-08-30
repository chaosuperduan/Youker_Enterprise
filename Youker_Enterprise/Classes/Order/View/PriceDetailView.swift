//
//  PriceDetailView.swift
//  youke
//
//  Created by apple on 2018/7/23.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class PriceDetailView: UIView,NibLoad {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var couponLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var PayPriceLabel: UILabel!
    
    @IBOutlet weak var dismiss: UIButton!
    
    @IBAction func dismissClick(_ sender: Any) {
        
        
        self.removeFromSuperview()
        
    }
    var mode:OrderMode?{
        didSet{
            if mode != nil {
                refreshUI()
            }
            
        }
        
    }
    func refreshUI(){
        countLabel.text = "x"+"\(String(describing: mode!.orders!.booking_Num))"
         priceLabel.text = "x" + "\(mode!.orders!.unit_Price)"
        PayPriceLabel.text = "实付：￥" + "\(mode!.orders!.price)"
        daysLabel.text = "x" + "\( NSDate.daysCalculate(TimeTool.getTimeStrWithInt(time: (mode?.orders?.booking_CheckIn_Date)!), endDays: TimeTool.getTimeStrWithInt(time: (mode?.orders?.booking_Leave_Date)!)))"
        
        
    }
    
    
}
