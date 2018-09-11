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
                
                
            }else{
              
               
                callback1()
            }
        }
    }
    

}
