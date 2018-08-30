//
//  OrderDetailSecondView.swift
//  youke
//
//  Created by keelon on 2018/7/9.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class OrderDetailSecondView: UIView ,NibLoad{
    var mode:OrderMode?{
        didSet{
            refreshUI()
            
        }
    }
    
    var callback:((_ str:NSInteger)->())?
    
    
    
    @IBOutlet weak var HotelNameLabel: UILabel!
    
    @IBOutlet weak var decorateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    @IBAction func startNavi(_ sender: Any) {
        if self.callback != nil  {
            callback!(1)
        }
        
        
    }
    
    @IBAction func Phone(_ sender: Any) {
        if self.callback != nil  {
             callback!(2)
        }
       
    }
    func refreshUI(){
       HotelNameLabel.text = mode?.hotelInfo?.hotel_Name
        decorateLabel.text = "(装修时间2017)"
       // book_personLabel.text = mode?.booking_Peoples
       addressLabel.text = mode?.hotelInfo?.hotel_Address
        distanceLabel.text = mode?.hotelInfo?.distanceText
    }
    
    
}
