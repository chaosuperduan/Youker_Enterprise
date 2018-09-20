//
//  AdminViewModel.swift
//  Youker_Enterprise
//
//  Created by keelon on 2018/9/18.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class AdminViewModel: NSObject {
    
    static let sharedInstance = AdminViewModel()
    //获取管理员列表。
    func GetCompanyAdmin(params:[String:AnyObject],orVC:AddAdminTableViewController?,callback1:@escaping (()->())){
        print(GetGroupByID)
        NetworkTools.requestData(.get, URLString:  GetAdminInfoURL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
                guard let modeDic:[[String:AnyObject]] = response?["data"] as! [[String : AnyObject]] else{
                    
                    
                    return
                }
                
                for dic in modeDic{
                    
                    let mode = User.init(dict: dic as! [String : NSObject])
                    orVC?.admins.append(mode)
                    
                }
                
               
                
                orVC?.tableView.reloadData()
            }else{
                
                
                callback1()
            }
        }
    }
    
    //添加管理员
    
    
    func ADDCompanyAdmin(params:[String:AnyObject],orVC:AddViewController?,callback1:@escaping (()->())){
        print(GetGroupByID)
        NetworkTools.requestData(.get, URLString:  AddEnterAdmURL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
                guard let responseDic:[String:AnyObject] = response as! [String : AnyObject] else{
                    
                    
                    return
                }
                let code:NSInteger = responseDic["code"] as! NSInteger
                
                if(code == 200){
                    
                    orVC?.ReqType =  RequestResultType.SUCCESS
                    callback1()
                }else{
                    
                    orVC?.ReqType  = RequestResultType.ERROR
                    orVC?.errorMessage = responseDic["message"] as! String
                    
                }
                
                
            }else{
                
                
                callback1()
            }
        }
    }
    
    //删除管理员。
    func DELETECompanyAdmin(params:[String:AnyObject],orVC:AddViewController?,callback1:@escaping (()->())){
        print(GetGroupByID)
        NetworkTools.requestData(.get, URLString:  DeleteEnterAdmURL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
                guard let responseDic:[String:AnyObject] = response as! [String : AnyObject] else{
                    
                    
                    return
                }
                let code:NSInteger = responseDic["code"] as! NSInteger
                
                if(code == 200){
                    
                    orVC?.ReqType =  RequestResultType.SUCCESS
                    callback1()
                }else{
                    
                    orVC?.ReqType  = RequestResultType.ERROR
                    orVC?.errorMessage = responseDic["message"] as! String
                    
                }
                
                
            }else{
                
                
                callback1()
            }
        }
    }
    
    


}
