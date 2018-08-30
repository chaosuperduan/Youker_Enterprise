//
//  PayAccount.swift
//  youke
//  Created by keelon on 2018/7/13.
//  Copyright © 2018年 M2Micro. All rights reserved.
//
import UIKit
//提现账户。
class PayAccount: BaseMode {
    @objc  var accountName:String?
    @objc  var accountIcon:String?
    @objc  var account_Number:String?
    @objc var account_Type:NSInteger = 0{
        didSet{
            if account_Type == 84 {
                accountName = "支付宝"
                accountIcon = "zhifu"
            }else{
                accountName = "微信"
                accountIcon = "wechat1"
            }
        }
    }
}
//提现记录。
class  WithdrawRecord: NSObject {
    @objc  var accountName:String?
    @objc  var accountIcon:String?
    @objc  var account_Number:String?
    @objc var account_Type:NSInteger = 0{
        didSet{
            if account_Type == 84 {
                accountName = "支付宝"
                accountIcon = "zhifu"
            }else{
                
                accountName = "微信"
                accountIcon = "wechat1"
            }
        }
    }
    @objc  var withdrawal_Time:NSInteger = 0{
        didSet{
            self.startTime = TimeTool.getTimeStrWithInt(time: withdrawal_Time)
        }
    }
    @objc  var withdrawal_State:NSInteger = 0
     @objc  var withdrawal_Account:String?
     @objc  var withdrawal_Amount:NSInteger = 0
     @objc  var withdrawal_Type:NSInteger = 0
    @objc  var user_Id:NSInteger = 0
    @objc var startTime:String?
     @objc  var record_Id:NSInteger = 0
    class func GetWithdrawalWithArray(array:[[String:AnyObject]])->[WithdrawRecord]{
    
        var arrays :[WithdrawRecord] = [WithdrawRecord]()
        
        for dic in array {
          let mode = WithdrawRecord()
            mode.setValuesForKeys(dic)
            arrays.append(mode)
            
            
        }
        
        return arrays
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
