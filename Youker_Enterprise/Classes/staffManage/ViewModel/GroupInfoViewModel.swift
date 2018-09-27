//
//  GroupInfoViewModel.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class GroupInfoViewModel: NSObject {
    
    static let sharedInstance = GroupInfoViewModel()
    
    func GetUserGroup(params:[String:AnyObject],orVC:ManageEnterUserTableViewController?,callback1:@escaping (()->())){
        print(GetGroupInfoAndUser)
        NetworkTools.requestData(.get, URLString:  GetGroupInfoAndUser, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
            guard let modeDic:[[String:AnyObject]] = response?["data"] as! [[String : AnyObject]] else{
                
//                
//               orVC?.ReqType = RequestResultType.NODATA
//             orVC?.header.endRefreshing()
//            callback1()
           return
           }
           for dic in modeDic{
                    
            let mode = UserGroupModel.init(dict: dic as! [String : NSObject])
            orVC?.dataArray.append(mode)
           }
                if((orVC?.dataArray.count)!<1){
                   orVC?.header.endRefreshing()
                    orVC?.ReqType = RequestResultType.NODATA
                }
                
           orVC?.tableView.reloadData()
              callback1()
                
            }else{
              
               
                callback1()
            }
        }
    }
    
    //添加企业分组。
func AddGroupInfo(params:[String:AnyObject],orVC:LimitationViewController?,callback1:@escaping (()->())){
    print("____________")
        print(addGroupInfo)
    print("++++++++++")
    
        NetworkTools.requestData(.post, URLString: addGroupInfo, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
                guard let modeDic:[String:AnyObject] = response as! [String : AnyObject] else{
                    
                  
                    return
                }
                
                let code:NSInteger = modeDic["code"] as! NSInteger
                if(code == 200) {
                    orVC?.ReqType = RequestResultType.SUCCESS
                    
                     callback1()
                }
                
            }else{
                orVC?.ReqType = RequestResultType.ERROR
                
                callback1()
            }
        }
        
    }
    
    //获取全部分组，及员工列表
    
    func GetGroupInfomation(params:[String:AnyObject],orVC:LimitationViewController?,callback1:@escaping (()->())){
        print(GetGroupInfo)
        NetworkTools.requestData(.get, URLString: GetGroupInfo, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
                let code:NSInteger = response?["code"] as! NSInteger
                
                guard let modeDic:[[String:AnyObject]] = response?["data"] as! [[String : AnyObject]] else{
                    
                    
                    return
                }
                if(orVC?.dataArray.count > 0){
                    
                     orVC?.dataArray.removeAll()
                }
               
                for dic in modeDic{
                    
                    let mode = UserGroupModel.init(dict: dic as! [String : NSObject])
                    mode.imge = "blueT"
                    
                    orVC?.dataArray.append(mode)
                }

                
                let mode = UserGroupModel(dict: [String:AnyObject]() as! [String : NSObject] )
                mode.group_Name = "自定义"
                mode.imge = "grayT"
                mode.company_Id = -7
                orVC?.dataArray.append(mode)
                callback1()
                
            }else{
                
                orVC?.showNoAuthority(title: mes!)
                callback1()
            }
        }
    }
    
    
    
    //获取分组和员工列表。
    func GetGroupAndUser(params:[String:AnyObject],orVC:LimitManageViewController?,callback1:@escaping (()->())){
        print(GetGroupByID)
        NetworkTools.requestData(.get, URLString:  GetGroupByID, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
                guard let modeDic:[String:AnyObject] = response?["data"] as! [String : AnyObject] else{
                    
                   
                    return
                }
          

                
                 let mode = UserGroupModel.init(dict: modeDic as! [String : NSObject])
                orVC?.DataMode = mode
                
                orVC?.tableview.reloadData()
            }else{
                
                
                callback1()
            }
        }
    }
    
    //邀请员工加入
    
    //添加员工。
    func ADDCompanyUser(params:[String:AnyObject],orVC:AddViewController?,callback1:@escaping (()->())){
        print(InviteURL)
        NetworkTools.requestData(.post, URLString:  InviteURL , parameters: params as? [String : Any]) { (response,mes) in
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
    //获取未分组的员工。
    
    func GetUserGroupOnGroupde(params:[String:AnyObject],orVC:AddGroupToUsersViewController?,callback1:@escaping (()->())){
        print(GetGroupInfoAndUser)
        NetworkTools.requestData(.get, URLString:  GetGroupInfoAndUser, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response != nil{
                
                guard let modeDic:[[String:AnyObject]] = response?["data"] as! [[String : AnyObject]] else{
                    
                    //
                    //               orVC?.ReqType = RequestResultType.NODATA
                    //             orVC?.header.endRefreshing()
                    //            callback1()
                    return
                }
                for dic in modeDic{
                    
                    let mode = UserGroupModel.init(dict: dic as! [String : NSObject])
                    if(mode.group_Name == "未分组"){
                       orVC?.mode = mode
                        
                    }
                }
                
                orVC?.tableview.reloadData()
                

                callback1()
                
            }else{
                
                
                callback1()
            }
        }
    }
    
    
    //批量添加员工到分组。
    
    //添加员工。
    func ADDUserToGroup(params:[String:AnyObject],orVC:AddGroupToUsersViewController?,callback1:@escaping (()->())){
        print(AddUserToGropURL)
        NetworkTools.requestData(.get, URLString:  AddUserToGropURL , parameters: params as? [String : Any]) { (response,mes) in
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
    
    //删除员工。
    
    //添加员工。
    func DELETECompanyUser(params:[String:AnyObject],orVC: ManageEnterUserTableViewController?,callback1:@escaping (()->())){
        print(DeleteEmployeeURL)
        NetworkTools.requestData(.get, URLString:  DeleteEmployeeURL , parameters: params as? [String : Any]) { (response,mes) in
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
                     callback1()
                }
                
               
                
                
            }else{
                
                
                callback1()
            }
        }
    }
    
    //修改企业分组信息
    
    func EditUserGroupInfo(params:[String:AnyObject],orVC: LimitManageViewController?,callback1:@escaping (()->())){
        print(DeleteEmployeeURL)
        NetworkTools.requestData(.get, URLString:  DeleteEmployeeURL , parameters: params as? [String : Any]) { (response,mes) in
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
                    callback1()
                }
                
                
            }else{
                
                
                callback1()
            }
        }
    }

    
    
    
    
    
    
    
    
    
    
    
}

//添加企业的分组信息。





