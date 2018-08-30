//
//  HotelInfo.swift
//  youke
//
//  Created by keelon on 2018/5/30.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit


class OrderMode: BaseMode {
    
     @objc var booking_Peoples:String?
    var isDelete:Bool = false
    var hotelInfo:HotelInfo?
    var orders:Orders?
    var roomInfo:RoomInfo?
    var room:Room?
    @objc var url:String?
    override init(dict: [String : NSObject]) {
        super.init(dict: dict)
        if (dict.keys.contains("hotelInfo")) {
           self.hotelInfo = HotelInfo.init(dict: (dict["hotelInfo"] as? [String : NSObject])!)
        }
       
        self.orders = Orders(dict: dict["orders"] as! [String : NSObject])
        guard let roomDic:[String:NSObject] =  dict["roomInfo"] as? [String : NSObject] else {
            return
        }
        self.roomInfo = RoomInfo.init(dict:roomDic)
        self.room = Room.init(dict:roomDic)
}
}
class HotelInfo: BaseMode {
   @objc var auto:NSInteger = 0
   @objc  var isdeleted:NSInteger = 0
    @objc var stop_Order:NSInteger = 0
    @objc var user_Id:NSInteger = 0
    @objc var reception_Phone:String?
    @objc var hotel_Introduce:String?
    @objc var hotel_Id:NSInteger = 0
   @objc  var detail_Position_X:Double = 0.1
   @objc  var detail_Position_Y:Double = 0.1
    @objc var hotel_Name:String?
     @objc var hotel_Address:String?
    @objc var distanceText:String?
    @objc  var distance:Double = 0.1{
        
        didSet{
           
            if (distance) > 1000.1 as! Double {
                distanceText = String.init(format: "%.2fkm", distance/1000.0)
           
                
            }else{
                distanceText = " "+"\(distance)" + "m"
             
            }
        }
    }
    
    
}

class Orders: BaseMode {
    
    @objc var booking_CheckIn_Date:NSInteger = 0{
        didSet{
            
            self.startTime = String.chanageDateString(str:TimeTool.getTimeStrWithInt(time: booking_CheckIn_Date) )
            self.starTimest = TimeTool.getTimeStrWithInt(time: booking_CheckIn_Date)
        }
        
    }
    @objc var booking_Leave_Date:NSInteger = 0{
        didSet{
            
            self.endTime = String.chanageDateString(str: TimeTool.getTimeStrWithInt(time: booking_Leave_Date))
            self.endTimest = TimeTool.getTimeStrWithInt(time: booking_Leave_Date)
        }
        
        
    }
    @objc var order_State:NSInteger = 0
   @objc var booking_Num:NSInteger = 0
   @objc var hotel_Id:NSInteger = 0
   @objc var is_Pay:NSInteger = 0
    @objc var is_Finish:NSInteger = 0
   @objc var isdeleted:NSInteger = 0
   @objc  var order_Date:NSInteger = 0
   @objc  var order_Id:NSInteger = 0
   @objc  var order_Number:NSInteger = 0
   @objc  var pay_Type:NSInteger = 0
   @objc  var price:Double = 0.08
   @objc  var user_Id:NSInteger = 0
   @objc var startTime:String?
   @objc var endTime:String?
    @objc var unit_Price:Double = 0.08
   @objc var endTimest:String?
    @objc var starTimest:String?
  // @objc var 
    
}
class RoomInfo: BaseMode {
    
   @objc  var air_Conditioning:NSInteger = 0
   @objc   var comments:String?
   @objc  var ihas_Blower:NSInteger = 0
   @objc  var has_Hyqient:NSInteger = 0
   @objc  var has_Park:NSInteger = 0
   @objc  var has_Tv:NSInteger = 0
  @objc   var has_WiFi:NSInteger = 0
  @objc   var hotel_Id:NSInteger = 0
   @objc  var price:NSInteger = 0
   @objc  var user_Id:NSInteger = 0
  @objc  var booking_Num:NSInteger = 0
  @objc   var isdeleted:NSInteger = 0
  @objc   var money:NSInteger = 0
@objc  var room_Beds:NSInteger = 0
  @objc   var room_Count:NSInteger = 0
 @objc    var order_Number:NSInteger = 0
 @objc    var room_Id:NSInteger = 0
 @objc    var room_Name:String?
 @objc    var room_Type:NSInteger = 0
  @objc   var same_Type:NSInteger = 0
    
}
