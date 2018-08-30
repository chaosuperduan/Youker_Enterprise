//
//  OrderDetailHeader.swift
//  youke
//
//  Created by keelon on 2018/7/9.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class OrderDetailHeader: UIView,NibLoad {
    var mode:OrderMode?{
        didSet{
            
           refreshUI()
            
        }
    }
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var typeNameLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func refreshUI(){
        self.hotelNameLabel.text = mode?.hotelInfo?.hotel_Name
        iconImageView.kf.setImage(with: URL.init(string: (mode?.url)!))
        countLabel.text = "\(String(describing: mode!.orders!.booking_Num))"
        typeNameLabel.text = self.mode?.roomInfo?.room_Name
        timeLabel.text = TimeTool.getTimeStrWithInt(time: (mode?.orders?.booking_CheckIn_Date)!)
    }
    
    
}
