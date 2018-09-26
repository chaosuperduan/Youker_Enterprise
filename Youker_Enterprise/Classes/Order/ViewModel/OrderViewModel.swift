//
//  OrderViewModel.swift
//  youke
//
//  Created by keelon on 2018/5/30.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit
class OrderViewModel: NSObject {

    static let shareInstance = OrderViewModel()
    func  loadOrders(params:[String:AnyObject],orVC:TotalTableViewController){
        
        NetworkTools.requestData(.post, URLString: OREDR_URL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                orVC.errorMessage = mes
                orVC.ReqType = RequestResultType.ERROR
                return
            }else{
               guard let data:[String:AnyObject] = response?["data"] as! [String : AnyObject] else{
                    return
                }
                
                guard let dataArray:[[String:AnyObject]] = data["data"] as! [[String : AnyObject]] else{
                    
                    return
                }
                var arrays:[OrderMode] = [OrderMode]()
                if dataArray.count>0{
                    for dic in dataArray{
                        let mode = OrderMode.init(dict: dic as! [String : NSObject])
                        arrays.append(mode)
                    }
                }else{
                    
                    orVC.ReqType = RequestResultType.NODATA
                }
                print(arrays.count)
                let a = arrays
               orVC.dataArrays = a
               }
        }
    }
    
    
    //获取订单详情
    func  load_detailOrders(params:[String:AnyObject],orVC:Order_DetailViewController){
        print(order_detail_URL)
        NetworkTools.requestData(.post, URLString: order_detail_URL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                orVC.errorMessage = mes
                orVC.ReqType = RequestResultType.ERROR
                return
            }else{
                guard let data:[String:AnyObject] = response?["data"] as! [String : AnyObject] else{
                    return
                }
                
            let mode = OrderMode.init(dict: data as! [String : NSObject])
            orVC.mode = mode
                
               
            }
        }
    }
}
    //退单退款。
    
    class OrderRefuse: NSObject {
        static let shareInstance = OrderRefuse()
        
        func refuseOrder(params:[String:AnyObject],orVc:TotalTableViewController?,callback1:((_ response:AnyObject?,_ msg:String?)->())?){
            
            print(LoginURL)
            NetworkTools.requestData(.post, URLString: refuseOrder_URL, parameters: params) { (response,mes) in
                print(response ?? "")
                if(orVc != nil){
                    if(mes != nil){
                        orVc?.errorMessage = mes
                        orVc?.ReqType = RequestResultType.ERROR
                        return
                        
                    }else{
                        orVc?.ReqType = RequestResultType.SUCCESS
                        
                        
                    }
                    
                    
                }else{
                    
                    callback1!(response as AnyObject,mes)
                    
                }
                
                
                
                
                
            }
        }
    }
    
//支付订单。
class payMode: NSObject {
     static let shareInstance = payMode()
    
    func Book(isAliPay:Bool,priceToken:String?,roomType:NSInteger,recordOrder:orderRecord,bookSum:NSInteger,same_Type:NSInteger){
        
        let param = NSMutableDictionary()
        let account = UserAccount.loadUserAccount()
        param["token"] = (account!.token)!
        
        if (priceToken != nil){
            
          param["priceToken"] = priceToken
            
        }else{
            
            param["priceToken"] = ""
        }
        
        param["roomType"] = roomType
        param["sameType"] = same_Type
        
        
        if isAliPay {
            recordOrder.pay_Type = 84
        }else{
            
            recordOrder.pay_Type = 85
        }
        recordOrder.booking_Num = bookSum
        let jsonStr:String = String.getJSONStringFromDictionary(dictionary: orderRecord.getDict(mode:recordOrder))
        let paramJson = NSMutableDictionary()
        print(jsonStr)
        param["orderRecord"] = jsonStr
        //       paramJson["token"] = account?.token
        NetworkTools.requestData(.post, URLString: SENDORDER_URL, parameters: param as? [String : Any], finishedCallback: { (response, msg) in
            if(isAliPay){
                if ((msg) != nil){
                    
                }else{
                    let str :String = response!["data"] as! String
                    AlipaySDK.defaultService().payOrder(str, fromScheme: "youker", callback: { (Dic) in
                        print("**************")
                        print(Dic)
                        print("**************")
                    })
                }
           }else{
                if(msg == nil){
                    let DIC :NSDictionary = response!["data"]! as! NSDictionary
                    print(DIC)
                    let timeStr:NSString = DIC["timestamp"] as! NSString
                    let timestramp:UInt32 = timeStr.integerValue.toU32
                    let opneid=DIC["appid"] as! String
                    let partnerID = DIC["partnerid"] as! String
                    let oncestr = DIC["noncestr"] as! String
                    let pakgStr = DIC["pkg"] as! String
                    let sign = DIC["sign"] as! String
                    let req = PayReq()
                    req.package = pakgStr
                    req.timeStamp = timestramp
//                    if(DIC.allKeys){
//
//
//
//                    }
                    guard let str:String = DIC["prepayid"] as? String else{
                        SVProgressHUD.showError(withStatus: "微信支付失败")
                        return
                    }
                    
                    req.prepayId = DIC["prepayid"] as! String
                    req.openID = opneid
                    req.partnerId = partnerID
                    req.nonceStr = oncestr
                    req.package = "Sign=WXPay"
                    req.sign = sign
                    WXApi.send(req)
                }else{
                    
                }
            }})
    }
    
    //删除订单。
    
}
//删除订单。
class DeleteOrderViewMode:NSObject{
    static let shareInstance = DeleteOrderViewMode()
    func  DeleteOrders(params:[String:AnyObject],orVC:TotalTableViewController){
        
        NetworkTools.requestData(.post, URLString: DeleteURL, parameters: params as? [String : Any]) { (response,mes) in
            print(response)
            if  response == nil{
                orVC.errorMessage = mes
                orVC.ReqType = RequestResultType.ERROR
                return
            }else{
                orVC.loadDatas()
            }
        }
    }
}

    

