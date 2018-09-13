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
  @objc  var imge:String = ""
  @objc  var company_Id:NSInteger = -1
  @objc  var group_Id
        :NSInteger = -1
  @objc  var group_Name :String?
  @objc  var maxPrice:NSInteger = 0
 @objc   var minPrice:NSInteger = 0
 @objc   var users:[User] = [User]()
   override init(dict: [String : NSObject]) {
        super.init(dict: dict)
    
        if (dict.keys.contains("users")) {
            guard let dicts:[[String:AnyObject]] = dict["users"] as? [[String : AnyObject]] else {
                return
            }
            users.removeAll()
            for dic  in dicts{
                
                let mode = User.init(dict: dic as! [String : NSObject])
                users.append(mode)
                
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
    
@objc    var company_Id:NSInteger = 0
@objc    var employee_Name:String?
@objc    var group_Id:NSInteger = 0
@objc    var invite_Time:NSInteger = 0
@objc    var invite_User:NSInteger = 0
@objc    var phoneNumber:String?
@objc    var record_Id:NSInteger = 0
@objc    var role_Type:NSInteger = 0
@objc    var user_Id:NSInteger = 0
    
    
}
