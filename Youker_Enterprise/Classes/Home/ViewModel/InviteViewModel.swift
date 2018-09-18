//
//  InviteViewModel.swift
//  Youker_Enterprise
//
//  Created by apple on 2018/9/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class InviteViewModel: NSObject {
    
    static let sharedInstance = InviteViewModel()
    
    func GetInviteUsers(params:[String:AnyObject],orVC:InviteTableViewController?,callback1:@escaping (()->())){
        print(RegisterMerchant)
        NetworkTools.requestData(.get, URLString:  GetUsersList, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                
                guard let responseArrays:[[String:AnyObject]] = response?["data"] as! [[String : AnyObject]] else{
                    return
                }
                
                for  dic in responseArrays{
                    
                   // let 
                    
                    
                }
               
                
                
                
            }else{
                
                //                orVC?.ReqType = RequestResultType.SUCCESS
                callback1()
                
            }
        }
    }
}
