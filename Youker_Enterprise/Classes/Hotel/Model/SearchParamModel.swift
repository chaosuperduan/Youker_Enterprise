//
//  SearchParamModel.swift
//  youke
//
//  Created by keelon on 2018/5/25.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

//搜索酒店模型类。
class SearchParamModel: NSObject {
    
    var checkInDate:String?
    var  leaveDate:String? 
    var price:NSInteger = 0
    var detailPositionX:Double = 0//经度位置
    var detailPositionY:Double = 0//纬度度位置
    var searchScope :Double = 0//搜索半径。
    class func getDict(mode:SearchParamModel)->NSDictionary{
        var dic:[String:AnyObject] = [String:AnyObject]()
        dic["checkInDate"] = mode.checkInDate as AnyObject
        dic["leaveDate"] = mode.leaveDate as AnyObject
        dic["price"] = mode.price as AnyObject
        dic["detailPositionX"] = mode.detailPositionX as AnyObject
        dic["detailPositionY"] = mode.detailPositionY as AnyObject
        return dic as NSDictionary
    }
}
//下单请求模型类。
class orderRecord: NSObject {
    var order_Id:NSInteger=0
    var user_Id:NSNumber?
    var booking_Num:NSInteger =  1
    var booking_CheckIn_Date:String?{
        didSet{
            if booking_CheckIn_Date == Date.getCurrentTime() {
               self.order_Type = 105
            }else{
                
               self.order_Type = 106
            }
        }
    }
    var booking_Leave_Date:String?//经度位置
    var order_Type:NSInteger = 0
    var hotel_Id:NSInteger = 0//纬度度位置
    var pay_Type :NSInteger = 84 //84支付宝//85微信//银行卡。
    class func getDict(mode:orderRecord)->NSDictionary{
        
        var dic:[String:AnyObject] = [String:AnyObject]()
        dic["user_Id"] = mode.user_Id as AnyObject
        dic["booking_Num"] = mode.booking_Num as AnyObject
        dic["booking_CheckIn_Date"] = mode.booking_CheckIn_Date as AnyObject
        dic["booking_Leave_Date"] = mode.booking_Leave_Date as AnyObject
        dic["hotel_Id"] = mode.hotel_Id as AnyObject
        dic["pay_Type"] = mode.pay_Type as AnyObject
        dic["order_Type"] = mode.order_Type as AnyObject
        if (mode.order_Id != 0){
            dic["order_Id"] = mode.order_Id as AnyObject
        }
        return dic as NSDictionary
    }
}

extension NSObject{
    
    
//    func getAllPropertys()->[String]{
//
//        var result = [String]()
//        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
//        let buff = class_copyPropertyList(object_getClass(self), count)
//        let countInt = Int(count[0])
//
////        for(var i=0;i<countInt;i++){
////            let temp = buff[i]
////            let tempPro = property_getName(temp)
////            let proper = String.init(UTF8String: tempPro)
////            result.append(proper!)
////
////        }
//
//        for i in 0..<countInt {
//
//            let temp = buff![i]
//                        let tempPro = property_getName(temp)
//                        let proper = String//String.init(UTF8String: tempPro)
//                        result.append(proper!)
//
//        }
//
//        return result
//    }
    
    
}
