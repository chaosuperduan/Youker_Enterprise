//
//  UserGroupModel.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
//企业员工和分组信息。

class UserGroupModel: BaseMode {
    var imge:String = ""
    var company_Id:NSInteger = -1
    var group_Id
        :NSInteger = -1
    var group_Name :String?
    var maxPrice:NSInteger = 0
    var minPrice:NSInteger = 0
    var users:[User]?
    override init(dict: [String : NSObject]) {
        super.init(dict: dict)
        if (dict.keys.contains("user")) {
            guard let dicts:[[String:AnyObject]] = dict["user"] as? [[String : AnyObject]] else {
                return
            }
            for dic  in dicts{
                
                let mode = User.init(dict: dic as! [String : NSObject])
                users?.append(mode)
                
            }
        }
        
        
    }
    class func getDic(mode:UserGroupModel)->NSDictionary{
        var dic:[String:AnyObject] = [String:AnyObject]()
        if mode.company_Id != -1 {
             dic["company_Id"] = mode.company_Id as AnyObject
        }
        if mode.group_Id != -1 {
            dic["group_Id"] = mode.group_Id as AnyObject
        }
       
        dic["group_Name"] = mode.group_Name as AnyObject
        if mode.maxPrice>0&&mode.minPrice>0 {
            dic["maxPrice"] = mode.maxPrice as AnyObject
            dic["minPrice"] = mode.minPrice as AnyObject
        }
       
        return dic as NSDictionary
    }
    
    

}

class User: BaseMode {
    
    var company_Id:NSInteger = 0
    var employee_Name:String?
    var group_Id:NSInteger = 0
    var invite_Time:NSInteger = 0
    var invite_User:NSInteger = 0
    var phoneNumber:String?
    var record_Id:NSInteger = 0
    var role_Type:NSInteger = 0
    var user_Id:NSInteger = 0
    
    
}
