//
//  cpyInfo.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class cpyInfo: BaseMode {
    var company_Address:String?
    var company_Name:String?
    var company_Phone:String?
    var law_person_Name:String?
    var reg_Address:String?
    var usccode:String?
    var userCount:String?
    class func getDic(mode:cpyInfo)->NSDictionary{
        var dic:[String:AnyObject] = [String:AnyObject]()
        dic["company_Address"] = mode.company_Address as AnyObject
        dic["company_Name"] = mode.company_Name as AnyObject
        dic["company_Phone"] = mode.company_Phone as AnyObject
        dic["law_person_Name"] = mode.law_person_Name as AnyObject
        dic["reg_Address"] = mode.reg_Address as AnyObject
        dic["usccode"] = mode.usccode as AnyObject
        dic["userCount"] = mode.userCount as AnyObject
        
        
    
       return dic as NSDictionary
    }
    
}

class districts:BaseMode{
   var regCity:String?
    var cpyDistrict:String?
    var cpyCity:String?
    var regDistrict:String?
    
    class func getDic(mode:districts)->NSDictionary{
        var dic:[String:AnyObject] = [String:AnyObject]()
        dic["regCity"] = mode.regCity as AnyObject
        dic["cpyDistrict"] = mode.cpyDistrict as AnyObject
        dic["cpyCity"] = mode.cpyCity as AnyObject
        dic["regDistrict"] = mode.regDistrict as AnyObject
        
        return dic as NSDictionary
        
    }
    
    
}
