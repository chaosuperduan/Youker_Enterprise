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
    var company_Id:NSInteger = 0
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
