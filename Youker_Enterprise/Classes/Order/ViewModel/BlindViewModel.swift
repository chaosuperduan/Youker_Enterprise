//
//  BlindViewModel.swift
//  youke
//
//  Created by keelon on 2018/7/12.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class BlindViewModel: NSObject {
    
   static let sharedInstance = BlindViewModel()
    //绑定支付账户
    func blindAccount(params:[String:AnyObject],orVC:AddAcountViewController?){
        
        NetworkTools.requestData(.post, URLString: BlindAccount, parameters: params) { (response, msg) in
            if(response == nil){
             print(response)
                //orVC?.dataArray = nil
            }else{
               
                orVC?.showSuccess()
            }
    }
    }
    //获取支付账户。
    func GetAccount(params:[String:AnyObject],orVC:BindingAccountTableViewController?,callback: (([PayAccount]?)->())?){
        NetworkTools.requestData(.post, URLString: getAccount, parameters: params) { (response, msg) in
            var AccountsArr = [PayAccount]()
            if(response == nil){
                print(response)
                //orVC?.dataArray = nil
            }else{
                let array :[[String:AnyObject]] = response!["data"] as! [[String:AnyObject]]
                
                if array == nil {
                    if(orVC != nil){
                        
                        orVC?.dataArray.removeAll()
                        orVC?.tableView.reloadData()
                      
                    }else{
                        
                        callback!(nil)
                    }
                   
                    
                }else{
                    for dic  in array{
                        
                        let mode =     PayAccount.init(dict: dic as! [String : NSObject])
                        AccountsArr.append(mode)
                        //orVC?.dataArray.append(mode)
                    }
                    if(orVC == nil){
                        callback!(AccountsArr)
                        
                    }else{
                        orVC?.dataArray = AccountsArr
                        if(orVC?.dataArray.count == 1){
                            let  mode = orVC?.dataArray[0]
                            if(mode?.account_Type == 84){
                                
                                let mode = PayAccount(dict: ["account_Type":85 as NSObject])
                                orVC?.dataArray.append(mode)
                            }else{
                                let mode = PayAccount(dict: ["account_Type":84 as NSObject])
                                orVC?.dataArray.append(mode)
                                
                            }
                            
                            
                            
                            
                        }
                        orVC?.tableView.reloadData()
                        
                        
                    }
                    
                   
                }
                
                }
                
                
            }
    }
  
    //更换支付账户
    
    func UpdateAccount(params:[String:AnyObject],orVC:AddAcountViewController?){
        
        NetworkTools.requestDataNOCheck(.post, URLString: UpdateAccounts, parameters: params) { (response, msg) in
            
            if(response == nil){
                print(response)
                //orVC?.dataArray = nil
            }else{
                
                orVC?.showSuccess()
            }
        }
        }
    
    //查询奖励金。
    
    func GetBonus(params:[String:AnyObject],callBack:@escaping ((data:AnyObject,msg:String))->()){
        
        NetworkTools.requestData(.post, URLString: getBonus, parameters: params) { (response, msg) in
            callBack((response as AnyObject,""))
        }
        
    }
    //提现奖励金
    func  WithdrawCashes(params:[String:AnyObject],callBack:@escaping ((data:AnyObject,msg:String))->()){
        print(extractBonus)
        NetworkTools.requestDataNOCheck(.post, URLString: extractBonus, parameters: params) { (response, msg) in
            callBack((response as AnyObject,msg!))
        }
        
    }
    //拿到分享url
    
    func  GetShareURL(params:[String:AnyObject],callBack:@escaping ((data:AnyObject,msg:String))->()){
        
        NetworkTools.requestDataNOCheck(.post, URLString: getShareURL, parameters: params) { (response, msg) in
            callBack((response as AnyObject,msg!))
            
        }
    }
    
    //获取提现记录。
    
   
    func  WithdrawRecord(params:[String:AnyObject],callBack:@escaping ((data:AnyObject,msg:String?))->()){
        
        NetworkTools.requestData(.post, URLString: getWithdrawal, parameters: params) { (response, msg) in
            
        
            callBack((response as AnyObject,nil))
            
            
        }
        
    }
    
    
}
