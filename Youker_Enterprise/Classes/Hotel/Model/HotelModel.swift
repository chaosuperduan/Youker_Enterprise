//
//  HotelModel.swift
//  youke
//
//  Created by keelon on 2018/5/26.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
class jpushMode: NSObject {
  
  @objc var hotels:[HotelModel]  = [HotelModel]()
  @objc  var message_Type:NSInteger = 0
  @objc  var push_Date:NSInteger = 0
  @objc  var title:[NSObject]?{
    
        didSet{
            guard let list = title else {
                return
            }
            for dic  in  list{
               let mode = HotelModel.init(dict: dic as! [String : NSObject])
               hotels.append(mode)
            }
        }
    }
    init(dict: [String: NSObject]) {
        super.init()
         //setValuesForKeys(dict)
        self.title = dict["title"] as? [NSObject]
        
        //self.push_Date = dict["publishDate"] as! NSInteger
    }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//
//    }
    
    
    
}

class HotelModel: BaseMode {
    @objc var distanceText:String?
    @objc  var distance:Double = 0.1{
        
       
            
            didSet{
                
                if (distance) > 1000.1 as! Double {
                    distanceText = " " + String.init(format: "%.2fkm", distance/1000.0)
                    
                    
                }else{
                    distanceText = " "+"\(distance)" + "m"
                    
                }
            }
       
    }
  @objc  var service_Score:NSInteger = 0
  @objc  var district:String?
  @objc  var auto:NSInteger = 0
  @objc  var detail_Position_X:Double = 0.0
  @objc  var detail_Position_Y:Double = 0.0
  @objc  var district_Code:NSInteger = 45454
  @objc  var hotel_Address:String?
  @objc  var hotel_Id:NSInteger = 0
  @objc  var hotel_Introduce:String?
  @objc  var hotel_Name:String?
  @objc  var hotel_Type:NSInteger = 0
  @objc  var isdeleted:NSInteger = 0
  @objc  var stop_Order:NSInteger = 0
  @objc var user_Id:NSInteger = 0
  @objc  var reception_Phone:String?
  @objc var pic:String?
    @objc var original_Price:NSInteger = 0
  @objc var maxOrderDate:String?
    
}
class BaseMode:NSObject{
//    class func initWithDic(dic:[String:AnyObject])->BaseMode{
//        let b = BaseMode()
//        b.setValuesForKeys(dic)
//        return b
//
//    }
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}


