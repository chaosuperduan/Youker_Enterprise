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
        print(RegisterMerchant)
        NetworkTools.requestData(.post, URLString:  RegisterMerchant, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                //                orVC?.errorMessage = mes
                //                orVC?.ReqType = RequestResultType.ERROR
                return
                
            }else{
              
               
                callback1()
                
            }
        }
    }
    

}
