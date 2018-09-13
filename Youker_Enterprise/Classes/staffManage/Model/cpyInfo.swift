//
//  cpyInfo.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/6.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class cpyInfo: NSObject,NSCoding{
   
    
 @objc   var company_Id:NSNumber?
 @objc   var company_Address:String?
 @objc   var company_Name:String?
@objc    var company_Phone:String?
@objc    var law_person_Name:String?
@objc    var reg_Address:String?
@objc    var usccode:String?
@objc    var userCount:NSInteger = 0
@objc    var userCount1:String?
    //存储位置的变量。
    static let filePath = "cpyInfo.plist".cachesDir()
    
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
    
    init(dict:[String:AnyObject]) {
        super.init()
        
        self.setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
        
        
        
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.company_Address = aDecoder.decodeObject(forKey: "company_Address") as? String
        self.company_Name = aDecoder.decodeObject(forKey: "company_Name") as? String
        
        self.company_Phone = aDecoder.decodeObject(forKey: "company_Phone") as? String
        
        self.company_Id = aDecoder.decodeObject(forKey: "company_Id") as? NSNumber
//        self.login_Type = aDecoder.decodeObject(forKey: "login_Type") as? NSNumber
        
        
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(company_Address, forKey: "company_Address")
        aCoder.encode(company_Name, forKey: "company_Name")
        aCoder.encode(company_Phone, forKey: "company_Phone")
        aCoder.encode(company_Id, forKey: "company_Id")
    }
    
    //移除。
    func removeAll(){
        if(FileManager.default.fileExists(atPath: "cpyInfo.plist".cachesDir())){
            print("文件存在")
            try? FileManager.default.removeItem(atPath: "useraccount.plist".cachesDir())
            
        }else{
            
            
        }
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


//groupInfo

class groupInfo: BaseMode{
    
    @objc   var group_Id:NSNumber?
    @objc   var company_Id:NSNumber?
    @objc   var company_Address:String?
    @objc   var company_Name:String?
    @objc    var company_Phone:String?
    @objc    var law_person_Name:String?
    @objc    var reg_Address:String?
    @objc    var usccode:String?
    @objc    var userCount:NSInteger = 0
    @objc    var userCount1:String?
    
    
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


