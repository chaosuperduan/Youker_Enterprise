//
//  businessInfo.swift
//  youke
//
//  Created by keelon on 2018/5/27.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class businessInfo:BaseMode {
   
 @objc var  auto:NSInteger = 0
 @objc var  business_Type:NSInteger = 0
 @objc var create_Time:NSInteger = 0
 @objc var  isdeleted:NSInteger = 0
 @objc var   isvaild:NSInteger = 0
 @objc var  license_Id:NSInteger = 0
 @objc var  service_Phone:NSInteger = 0
 @objc var  stop_Order:NSInteger = 0
 @objc var  subordinate_Address:NSInteger = 0
 @objc var  subordinate_Id:NSInteger = 0
 @objc var  subordinate_Name:NSInteger = 0
 @objc var user_Id:NSInteger = 0
 @objc var business_Name:String?
  @objc var business_Address:String?
    
    class func getDic(buInfo:businessInfo)->NSDictionary{
        var dic:[String:AnyObject] = [String:AnyObject]()
        
        if buInfo.business_Address != nil{
            
            dic["business_Address"] = buInfo.business_Address as AnyObject
            
        }
        
        if buInfo.business_Name != nil {
            dic["business_Name"] = buInfo.business_Name as AnyObject
        }
        
        return dic as NSDictionary
        
        
    }
    
}

class Room: BaseMode {
     @objc var roomArea:String?
    //预订数量。
    @objc  var  bookSUM:NSInteger = 1
    @objc var facilities:[String]? = [String]()
    @objc var equipment:[String]? = [String]()
    @objc  var  area:NSInteger = 1{
        didSet{
            roomArea = "\(area)"+"㎡"
        }
    }
    
    @objc var bed_commoment:String?
    @objc  var  bed_Width:NSInteger = 1
    @objc  var  bed_Length:NSInteger = 1{
        didSet{
            bed_commoment = "大床" + "\(bed_Length)"+"x"+"\(bed_Width)"+"m"
        }
        
       
    }
    @objc  var  air_Conditioning:NSInteger = 0{
        
        didSet{
            if air_Conditioning == 1 {
                facilities?.append("aircontioner")
                equipment?.append("空调")
            }
            
        }
    }
   @objc   var  comments:String?
    @objc  var  has_Blower:NSInteger = 0{
        didSet{
            if has_Blower == 1 {
                facilities?.append("blower")
                equipment?.append("吹风机")
            }
            
        }
        
    }
    @objc  var  has_Tv:NSInteger = 0{
        
        didSet{
            if has_Tv == 1 {
                facilities?.append("tv")
                equipment?.append("电视机")
            }
            
        }
        
    }
    @objc  var  has_WiFi:NSInteger = 0{
        didSet{
            if has_WiFi == 1 {
                facilities?.append("wifi")
                equipment?.append("免费WIFI")
            }
            
        }
    }
    @objc  var  has_Window:NSInteger = 0{
        
        didSet{
            if has_Window == 1{
                //facilities?.append("Window")
            }
            
        }
        
    }
    @objc  var  has_Breakfast:NSInteger = 0{
        
        didSet{
            if has_Breakfast == 1 {
                facilities?.append("breakfast")
                equipment?.append("含早餐")
            }
            
        }
    }
    @objc  var  has_Hyqient:NSInteger = 0{
        
        didSet{
            if has_Breakfast == 1 {
                facilities?.append("washroom")
                equipment?.append("独立卫生间")
            }
            
        }
    }
    @objc  var  has_Park:NSInteger = 0{
        didSet{
            if has_Park == 1{
                facilities?.append("park")
                equipment?.append("停车场")
            }
            
        }
    }
   @objc   var  room_Count:NSInteger = 0
   @objc  var  room_Id:NSInteger = 0
   @objc  var  auto:NSInteger = 0
   @objc  var   room_Name:String?
   @objc  var room_Type:NSInteger = 0
   @objc  var same_Type:NSInteger = 0
    @objc var money:NSInteger = 0
    @objc var original_Price:NSInteger = 0
    @objc  var pictures:[String] = [String]()
   
    class func getRoomArrays(DicArray:[[String:AnyObject]])->[Room]{
        var arrays = [Room]()
        for dic in DicArray{
            let mode = Room.init(dict: dic as! [String : NSObject])
            mode.pictures = dic["pictures"] as! [String]
            arrays.append(mode)
        }
        return arrays
    }
//    override init(dict: [String : NSObject]) {
//        super.init(dict: dict)
//        
//    }
}




