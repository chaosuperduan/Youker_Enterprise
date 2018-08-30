//
//  HotelViewModel.swift
//  youke
//
//  Created by keelon on 2018/5/30.
//  Copyright © 2018年 M2Micro. All rights reserved.
//

import UIKit

class HotelViewModel: NSObject {
    static let shareInstance = HotelViewModel()
    func getHotelWithVC(VC:HotelViewController){
        let account = UserAccount.loadUserAccount()
        let jsonRoom = String.getJSONStringFromDictionary(dictionary:SearchParamModel.getDict(mode: VC.params!))
        print(jsonRoom)
        let jsparam = ["hotel_Id": VC.mode?.hotel_Id ?? 0,"factor":jsonRoom,"token":(account?.token)!] as [String : Any]
        print(jsparam)
        NetworkTools.requestData(.post, URLString:HotelDetailURL, parameters: jsparam as? [String : Any]) { (response,mes) in
            if  response == nil{
                VC.errorMessage = mes
                VC.ReqType = RequestResultType.ERROR
                return
            }else{
                guard let DIc:[String:AnyObject] = response!["data"] as! [String : AnyObject]else{
                    return
                }
               
                guard let  HoDic :[[String:AnyObject]] = DIc["rooms"] as! [[String : AnyObject]] else{
                    return
                }
                
                 VC.rooms = Room.getRoomArrays(DicArray: HoDic)
                guard let  businessInfoDic :[String:AnyObject] = DIc["businessInfo"] as? [String : AnyObject] else{
                    return
                }
               
                VC.buInfo = businessInfo(dict: businessInfoDic as! [String : NSObject])
                
                VC.tableview.reloadData()
                print(response ?? "错误")
            }
         }
        print("刷新表格")
    }
    
}
